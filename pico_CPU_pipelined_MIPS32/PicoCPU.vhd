--Copyright (C) 2017 Siavoosh Payandeh Azad

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use work.pico_cpu.all;

entity PicoCPU is
  generic (Mem_preload_file: string :="code.txt");
  port(
    rst: in std_logic;
    clk: in std_logic;
    IO: inout std_logic_vector (CPU_Bitwidth-1 downto 0)
  );
end PicoCPU;


architecture RTL of PicoCPU is
---------------------------------------------
--      Signals
---------------------------------------------
signal Instr_In        : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal Instr_Add, Instr_Add_mem : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal MemRdAddress    : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal MemWrtAddress   : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal Mem_RW          : std_logic_vector (3 downto 0);
 ----------------------------------------
signal IO_DIR          : std_logic;
signal IO_RD           : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal IO_WR           : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_OV          : std_logic;
signal DataToDPU_2       : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_ALUCommand  : ALU_COMMAND;
signal DPU_Mux_Cont_2  : DPU_IN_MUX;
 ----------------------------------------
signal RFILE_data_sel  : RFILE_IN_MUX;
signal Data_to_RFILE   : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal RFILE_in_address: std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
signal WB_enable       :  std_logic_vector (3 downto 0);
signal RFILE_out_sel_1, RFILE_out_sel_1_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
signal RFILE_out_sel_2, RFILE_out_sel_2_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);

signal DPU_RESULT, DPU_RESULT_out : std_logic_vector (2*CPU_Bitwidth-1 downto 0);
signal Result_ACC   : std_logic_vector (2*CPU_Bitwidth-1 downto 0);

-- Register file outputs
signal R1, R2, R2_FF   : std_logic_vector (CPU_Bitwidth-1 downto 0);

signal MEMDATA_OUT, MEMDATA_IN: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal Mem_Rd_Address_in : std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MEM_IN_SEL  : MEM_IN_MUX;

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
  CLOCK_PROCESS:process (clk, rst)begin
    if rst = '1' then

      RFILE_out_sel_1<= (others => '0');
      RFILE_out_sel_2<= (others => '0');
      R2_FF <= (others => '0');
      DPU_RESULT_out <= (others => '0');
    elsif clk'event and clk='1' then
      RFILE_out_sel_1<= RFILE_out_sel_1_in;
      RFILE_out_sel_2<= RFILE_out_sel_2_in;
      R2_FF <= R2;
      DPU_RESULT_out <= DPU_RESULT;
    end if;
  end process;

  gpio_comp: GPIO
  generic map (BitWidth => CPU_Bitwidth)
  port map (IO_DIR, IO, IO_WR, IO_RD);

  ControlUnit_comp: ControlUnit
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (
        rst             => rst            ,
        clk             => clk            ,
        -------------------------------------------
        Instr_In        => Instr_In       ,
        Instr_Add       => Instr_Add      ,
        -------------------------------------------
        MemRdAddress    => MemRdAddress   ,
    	  MemWrtAddress   => MemWrtAddress  ,
        Mem_RW          => Mem_RW         ,
        MEM_IN_SEL      => MEM_IN_SEL     ,
        -------------------------------------------
        IO_DIR          => IO_DIR         ,
        IO_RD           => IO_RD          ,
        IO_WR           => IO_WR          ,
        -------------------------------------------
        DPU_OV          => DPU_OV         ,
        DataToDPU_2     => DataToDPU_2    ,

        DPU_ALUCommand  => DPU_ALUCommand ,
        DPU_Mux_Cont_2  => DPU_Mux_Cont_2 ,
        -------------------------------------------
        RFILE_data_sel  => RFILE_data_sel ,
    	  RFILE_in_address=> RFILE_in_address   ,
        RFILE_WB_enable => WB_enable,
    	  RFILE_out_sel_1 => RFILE_out_sel_1_in,
    	  RFILE_out_sel_2 => RFILE_out_sel_2_in,
        Data_to_RFILE   => Data_to_RFILE ,

        DPU_RESULT      => DPU_RESULT     ,
        Result_ACC   => Result_ACC
        );

  --register file
  RegFile_comp: RegisterFile
  generic map (BitWidth => CPU_Bitwidth)
  port map (

    clk                => clk,
    rst                => rst,
    Data_in_mem        => MEMDATA_OUT,
    Data_in_CU         => Data_to_RFILE,
    Data_in_DPU_LOW    => DPU_RESULT_out(CPU_Bitwidth-1 downto 0),
    Data_in_ACC_HI     => Result_ACC(2*CPU_Bitwidth-1 downto CPU_Bitwidth),
    Data_in_ACC_LOW    => Result_ACC(CPU_Bitwidth-1 downto 0),
    Data_in_R2         => R2_FF,
    Data_in_sel        => RFILE_data_sel,
    RFILE_in_address   => RFILE_in_address,
    WB_enable          => WB_enable,
    Register_out_sel_1 => RFILE_out_sel_1,
    Register_out_sel_2 => RFILE_out_sel_2,
    Data_out_1         => R1,
    Data_out_2         => R2);

  --datapath unit
  DPU_comp: DPU
  generic map (BitWidth => CPU_Bitwidth)
  port map (
            rst              => rst,
            clk              => clk,
            Data_in_mem      => MEMDATA_OUT,
            Data_in_RegFile_1=> R1,
            Data_in_RegFile_2=> R2,
            Data_in_control_2=> DataToDPU_2,

            ALUCommand       => DPU_ALUCommand,
            Mux_Cont_2       => DPU_Mux_Cont_2,
            DPU_OV           => DPU_OV,
            Result           => DPU_RESULT,
            Result_ACC       => Result_ACC);

-- MEMORY Input select MUX
  MEM_DATA_IN_SELECT: process(MEM_IN_SEL, RFILE_out_sel_1, RFILE_out_sel_2, DPU_Result)begin
    case( MEM_IN_SEL ) is
      when RFILE_DATA_1 => MEMDATA_IN <= R1;
      when RFILE_DATA_2 => MEMDATA_IN <= R2;
      when DPU_DATA     => MEMDATA_IN <= DPU_Result(CPU_Bitwidth-1 downto 0);
      when others => MEMDATA_IN <= (others => '0');
    end case;

  end process;
  --memory
  Instr_Add_mem <= "00" & Instr_Add(CPU_Bitwidth-1 downto 2);

  Mem_comp: RAM
  generic map (BitWidth => CPU_Bitwidth, preload_file => Mem_preload_file)
  port map (MemRdAddress, Instr_Add_mem, MEMDATA_IN, MemWrtAddress, clk, Mem_RW , rst , MEMDATA_OUT,  Instr_In);

end RTL;
