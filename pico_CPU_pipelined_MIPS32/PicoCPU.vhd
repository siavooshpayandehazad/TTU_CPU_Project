--Copyright (C) 2017 Siavoosh Payandeh Azad

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use work.pico_cpu.all;

entity PicoCPU is
  port(
    rst: in std_logic;
    clk: in std_logic;
	  FlagOut: out std_logic_vector ( 3 downto 0);
    IO: inout std_logic_vector (CPU_Bitwidth-1 downto 0);
	  output: out std_logic_vector ( 2*CPU_Bitwidth-1 downto 0)
  );
end PicoCPU;


architecture RTL of PicoCPU is
---------------------------------------------
--      Signals
---------------------------------------------


signal Instr_In        : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal Instr_Add       : std_logic_vector (CPU_Bitwidth+1 downto 0);
 ----------------------------------------
signal MemRdAddress    : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal MemWrtAddress   : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal Mem_RW          : std_logic_vector (3 downto 0);
 ----------------------------------------
signal IO_DIR          : std_logic;
signal IO_RD           : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal IO_WR           : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_Flags       : std_logic_vector (3 downto 0);
signal DPU_Flags_FF    : std_logic_vector (3 downto 0);
signal DataToDPU_1, DataToDPU_2       : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_ALUCommand, DPU_ALUCommand_in  : ALU_COMMAND;
signal DPU_Mux_Cont_1, DPU_Mux_Cont_1_in  : DPU_IN_MUX;
signal DPU_Mux_Cont_2, DPU_Mux_Cont_2_in  : DPU_IN_MUX;
signal DPU_SetFlag   , DPU_SetFlag_in  : std_logic_vector (2 downto 0);
 ----------------------------------------
signal RFILE_data_sel  : RFILE_IN_MUX;
signal Data_to_RFILE   : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal RFILE_in_address: std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
signal WB_enable       :  std_logic_vector (3 downto 0);
signal RFILE_out_sel_1, RFILE_out_sel_1_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
signal RFILE_out_sel_2, RFILE_out_sel_2_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);

signal flush_pipeline  : std_logic;
signal DPU_RESULT      : std_logic_vector (2*CPU_Bitwidth-1 downto 0);
signal DPU_RESULT_FF   : std_logic_vector (2*CPU_Bitwidth-1 downto 0);

-- Register file outputs
signal R1, R2, R2_FF   : std_logic_vector (CPU_Bitwidth-1 downto 0);

signal MEMDATA_OUT, MEMDATA_IN: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal Mem_Rd_Address_in : std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MEM_IN_SEL  : MEM_IN_MUX;

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
  process (clk, rst)begin
    if rst = '1' then

      RFILE_out_sel_1<= (others => '0');
      RFILE_out_sel_2<= (others => '0');
      R2_FF <= (others => '0');
    elsif clk'event and clk='1' then
      RFILE_out_sel_1<= RFILE_out_sel_1_in;
      RFILE_out_sel_2<= RFILE_out_sel_2_in;
      R2_FF <= R2;
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
        ----------------=> ---------------,--------
        Instr_In        => Instr_In       ,
        Instr_Add       => Instr_Add      ,
        ----------------=> ---------------,--------
        MemRdAddress    => MemRdAddress   ,
    	  MemWrtAddress   => MemWrtAddress  ,
        Mem_RW          => Mem_RW         ,
        MEM_IN_SEL      => MEM_IN_SEL     ,
        ----------------=> ---------------,--------
        IO_DIR          => IO_DIR         ,
        IO_RD           => IO_RD          ,
        IO_WR           => IO_WR          ,
        ----------------=> ---------------,--------
        DPU_Flags       => DPU_Flags      ,
        DPU_Flags_FF    => DPU_Flags_FF   ,
        DataToDPU_1     => DataToDPU_1    ,
        DataToDPU_2     => DataToDPU_2    ,

        DPU_ALUCommand  => DPU_ALUCommand ,
        DPU_Mux_Cont_1  => DPU_Mux_Cont_1 ,
        DPU_Mux_Cont_2  => DPU_Mux_Cont_2 ,
        DPU_SetFlag     => DPU_SetFlag    ,
        ----------------=> ---------------,--------
        RFILE_data_sel  => RFILE_data_sel ,
    	  RFILE_in_address=> RFILE_in_address   ,
        RFILE_WB_enable => WB_enable,
    	  RFILE_out_sel_1 => RFILE_out_sel_1_in,
    	  RFILE_out_sel_2 => RFILE_out_sel_2_in,
        Data_to_RFILE   => Data_to_RFILE ,

    	  flush_pipeline  => flush_pipeline ,
        DPU_RESULT      => DPU_RESULT     ,
        DPU_RESULT_FF   => DPU_RESULT_FF
        );

  --instruction memory
  InstMem_comp: InstMem
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (Instr_Add(CPU_Bitwidth+1 downto 2), Instr_In);

  --register file
  RegFile_comp: RegisterFile
  generic map (BitWidth => CPU_Bitwidth)
  port map (

    clk                => clk,
    rst                => rst,
    Data_in_mem        => MEMDATA_OUT,
    Data_in_CU         => Data_to_RFILE,
    Data_in_DPU_HI     => DPU_RESULT(2*CPU_Bitwidth-1 downto CPU_Bitwidth),
    Data_in_DPU_LOW    => DPU_RESULT(CPU_Bitwidth-1 downto 0),
    Data_in_ACC_HI     => DPU_RESULT_FF(2*CPU_Bitwidth-1 downto CPU_Bitwidth),
    Data_in_ACC_LOW    => DPU_RESULT_FF(CPU_Bitwidth-1 downto 0),
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
            Data_in_control_1=> DataToDPU_1,
            Data_in_control_2=> DataToDPU_2,

            ALUCommand       => DPU_ALUCommand,
            Mux_Cont_1       => DPU_Mux_Cont_1,
            Mux_Cont_2       => DPU_Mux_Cont_2,
            SetFlag          => DPU_SetFlag   ,

            DPU_Flags        => DPU_Flags,
            DPU_Flags_FF     => DPU_Flags_FF,
            Result           => DPU_RESULT,
            Result_FF        => DPU_RESULT_FF);


MEM_DATA_IN_SELECT: process(MEM_IN_SEL, RFILE_out_sel_1, RFILE_out_sel_2, DPU_Result)begin
    case( MEM_IN_SEL ) is
      when RFILE_DATA_1 => MEMDATA_IN <= R1;
      when RFILE_DATA_2 => MEMDATA_IN <= R2;
      when DPU_DATA     => MEMDATA_IN <= DPU_Result(CPU_Bitwidth-1 downto 0);
      when others => MEMDATA_IN <= (others => '0');
    end case;

  end process;
  --memory
  Mem_comp: Memory
  generic map (BitWidth => CPU_Bitwidth)
  port map (MemRdAddress, MEMDATA_IN, MemWrtAddress, clk, Mem_RW , rst , MEMDATA_OUT);

  FlagOut <=	DPU_Flags_FF;
  output <= DPU_RESULT_FF;
end RTL;
