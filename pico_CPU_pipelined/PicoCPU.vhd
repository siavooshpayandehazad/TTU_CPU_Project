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
signal Instr: std_logic_vector (CPU_Instwidth-1 downto 0):= (others=>'0');
signal InstrAdd , MEMDATA, DPU_Result, DataFromDPU_bypass: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal DPUData, DPUData_in: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal Mem_Rd_Address_in : std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MemRW_1, MemRW_in: std_logic := '0';
signal Mem_Wrt_Address_1, Mem_Wrt_Address_in,  Mem_Wrt_Address_2: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MemRW_2: std_logic := '0';
signal DPUFlags, DPUFlags_FF: std_logic_vector (3 downto 0):= (others=>'0');
signal DPUCommand, DPUCommand_in : std_logic_vector (10 downto 0):= (others=>'0');
signal Reg_in_sel: std_logic_vector (7 downto 0):= (others=>'0');
signal Reg_out_sel: std_logic_vector (2 downto 0):= (others=>'0');
signal Reg_file_out: std_logic_vector (CPU_Bitwidth-1 downto 0):= (others=>'0');
signal flush_pipeline: std_logic;
signal IO_WR, IO_RD: std_logic_vector(CPU_Bitwidth-1 downto 0):= (others=>'0');
signal IO_DIR : std_logic;

alias data_in_sel : std_logic_vector (1 downto 0) is DPUCommand_in (10 downto 9);

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
  process (clk, rst)begin
    if rst = '1' then
      DPUCommand <= (others => '0');
      Mem_Wrt_Address_1 <= (others => '0');
      MemRW_1 <= '0';
      Mem_Wrt_Address_2 <= (others => '0');
      MemRW_2 <= '0';
      DPUData <= (others => '0');
    elsif clk'event and clk='1' then
      DPUCommand <= DPUCommand_in;
      Mem_Wrt_Address_1 <= Mem_Wrt_Address_in;
      MemRW_1 <= MemRW_in;
      Mem_Wrt_Address_2 <= Mem_Wrt_Address_1;
      MemRW_2 <= MemRW_1;
      DPUData <= DPUData_in;
    end if;
  end process;

  gpio_comp: GPIO
  generic map (BitWidth => CPU_Bitwidth)
  port map (IO_DIR, IO, IO_WR, IO_RD);

  ControlUnit_comp: ControlUnit
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (rst, clk, Instr ,InstrAdd , Mem_Rd_Address_in, Mem_Wrt_Address_in,
            MemRW_in, IO_DIR, IO_RD, IO_WR, DPUFlags, DPUFlags_FF, DPUData_in, DPUCommand_in,
            Reg_in_sel, Reg_out_sel, flush_pipeline, DataFromDPU_bypass, DPU_Result);
  --instruction memory
  InstMem_comp: InstMem
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (InstrAdd,Instr);

  --register file
  RegFile_comp: RegisterFile
  generic map (BitWidth => CPU_Bitwidth)
  port map (clk, rst, MEMDATA, DPUData_in, DPU_Result, data_in_sel, Reg_in_sel, Reg_out_sel, Reg_file_out);

  --datapath unit
  DPU_comp: DPU
  generic map (BitWidth => CPU_Bitwidth)
  port map (rst, clk, MEMDATA, Reg_file_out, DPUData,  DPUCommand, DPUFlags, DPUFlags_FF, DataFromDPU_bypass, DPU_Result);
  --memory
  Mem_comp: Mem
  generic map (BitWidth => CPU_Bitwidth)
  port map (Mem_Rd_Address_in, DPU_Result, Mem_Wrt_Address_2, clk, MemRW_2 , rst , MEMDATA);

  FlagOut <=	DPUFlags;
  output <= DPU_Result;
end RTL;
