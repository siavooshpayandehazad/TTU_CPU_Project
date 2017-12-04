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
	  output: out std_logic_vector ( CPU_Bitwidth-1 downto 0)
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
signal Mem_RW          : std_logic;
 ----------------------------------------
signal IO_DIR          : std_logic;
signal IO_RD           : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal IO_WR           : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_Flags       : std_logic_vector (3 downto 0);
signal DPU_Flags_FF    : std_logic_vector (3 downto 0);
signal DataToDPU,DataToDPU_in       : std_logic_vector (CPU_Bitwidth-1 downto 0);
 ----------------------------------------
signal DPU_ALUCommand, DPU_ALUCommand_in  : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
signal DPU_Mux_Cont_1, DPU_Mux_Cont_1_in  : std_logic_vector (1 downto 0);
signal DPU_Mux_Cont_2, DPU_Mux_Cont_2_in  : std_logic_vector (1 downto 0);
signal DPU_SetFlag   , DPU_SetFlag_in  : std_logic_vector (2 downto 0);
 ----------------------------------------
signal RFILE_data_sel  : std_logic_vector (1 downto 0);
signal Data_to_RFILE   : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal RFILE_in_sel    : std_logic_vector (RFILE_SEL_WIDTH downto 0);
signal RFILE_out_sel_1, RFILE_out_sel_1_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
signal RFILE_out_sel_2, RFILE_out_sel_2_in : std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);

signal flush_pipeline  : std_logic;
signal DPU_RESULT      : std_logic_vector (CPU_Bitwidth-1 downto 0);
signal DPU_RESULT_FF   : std_logic_vector (CPU_Bitwidth-1 downto 0);

-- Register file outputs
signal R1, R2          : std_logic_vector (CPU_Bitwidth-1 downto 0);

signal MEMDATA: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal Mem_Rd_Address_in : std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MemRW_1, MemRW_2: std_logic := '0';
signal Mem_Wrt_Address_1, Mem_Wrt_Address_2: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
  process (clk, rst)begin
    if rst = '1' then

      Mem_Wrt_Address_1 <= (others => '0');
      MemRW_1 <= '0';
      Mem_Wrt_Address_2 <= (others => '0');
      MemRW_2 <= '0';

      RFILE_out_sel_1<= (others => '0');
      RFILE_out_sel_2<= (others => '0');
    elsif clk'event and clk='1' then
      RFILE_out_sel_1<= RFILE_out_sel_1_in;
      RFILE_out_sel_2<= RFILE_out_sel_2_in;

      Mem_Wrt_Address_1 <= MemWrtAddress;
      MemRW_1 <= Mem_RW;
      Mem_Wrt_Address_2 <= Mem_Wrt_Address_1;
      MemRW_2 <= MemRW_1;

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
        ----------------=> ---------------,--------
        IO_DIR          => IO_DIR         ,
        IO_RD           => IO_RD          ,
        IO_WR           => IO_WR          ,
        ----------------=> ---------------,--------
        DPU_Flags       => DPU_Flags      ,
        DPU_Flags_FF    => DPU_Flags_FF   ,
        DataToDPU       => DataToDPU      ,

        DPU_ALUCommand  => DPU_ALUCommand ,
        DPU_Mux_Cont_1  => DPU_Mux_Cont_1 ,
        DPU_Mux_Cont_2  => DPU_Mux_Cont_2 ,
        DPU_SetFlag     => DPU_SetFlag    ,
        ----------------=> ---------------,--------
        RFILE_data_sel  => RFILE_data_sel ,
    	  RFILE_in_sel    => RFILE_in_sel   ,
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
    Data_in_mem        => MEMDATA,
    Data_in_CU         => Data_to_RFILE,
    Data_in_ACC        => DPU_RESULT_FF,
    Data_in_sel        => RFILE_data_sel,
    Register_in_sel    => RFILE_in_sel,
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
            Data_in_mem      => MEMDATA,
            Data_in_RegFile_1=> R1,
            Data_in_RegFile_2=> R2,
            Data_in_control_1=> DataToDPU,
            Data_in_control_2=> DataToDPU,

            ALUCommand       => DPU_ALUCommand,
            Mux_Cont_1       => DPU_Mux_Cont_1,
            Mux_Cont_2       => DPU_Mux_Cont_2,
            SetFlag          => DPU_SetFlag   ,

            DPU_Flags        => DPU_Flags,
            DPU_Flags_FF     => DPU_Flags_FF,
            Result           => DPU_RESULT,
            Result_FF        => DPU_RESULT_FF);

  --memory
  Mem_comp: Mem
  generic map (BitWidth => CPU_Bitwidth)
  port map (Mem_Rd_Address_in, DPU_Result, Mem_Wrt_Address_2, clk, MemRW_2 , rst , MEMDATA);

  FlagOut <=	DPU_Flags_FF;
  output <= DPU_RESULT_FF;
end RTL;
