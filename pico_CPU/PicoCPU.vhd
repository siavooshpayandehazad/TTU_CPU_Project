library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use work.pico_cpu.all;

entity PicoCPU is
  port(
    rst: in std_logic;
    clk: in std_logic;
	 FlagOut: out std_logic_vector ( 3 downto 0);
	 output: out std_logic_vector ( CPU_Bitwidth-1 downto 0)
  );
end PicoCPU;


architecture RTL of PicoCPU is
---------------------------------------------
--      Signals
---------------------------------------------
signal Instr: std_logic_vector (CPU_Instwidth-1 downto 0):= (others=>'0');
signal InstrAdd , Mem_Rd_Address, Mem_Wrt_Address, DPUData, MEMDATA, DPU_Result: std_logic_vector (CPU_Bitwidth-1 downto 0) := (others=>'0');
signal MemRW: std_logic := '0';
signal DPUFlags: std_logic_vector (3 downto 0):= (others=>'0');
signal DPUCommand : std_logic_vector (10 downto 0):= (others=>'0');
signal Reg_in_sel: std_logic_vector (7 downto 0):= (others=>'0');
signal Reg_out_sel: std_logic_vector (2 downto 0):= (others=>'0');

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
  ControlUnit_comp: ControlUnit
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (rst, clk, Instr ,InstrAdd , Mem_Rd_Address, Mem_Wrt_Address , MemRW, DPUFlags, DPUData,DPUCommand,Reg_in_sel,Reg_out_sel,DPU_Result);
  --instruction memory
  InstMem_comp: InstMem
  generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
  port map (InstrAdd,Instr);
  --datapath unit
  DPU_comp: DPU
  generic map (BitWidth => CPU_Bitwidth)
  port map (MEMDATA, DPUData, clk,DPUCommand,Reg_in_sel,Reg_out_sel,rst,DPUFlags,DPU_Result);
  --memory
  Mem_comp: Mem
  generic map (BitWidth => CPU_Bitwidth)
  port map (Mem_Rd_Address, DPU_Result, Mem_Wrt_Address, clk,MemRW , rst , MEMDATA);

  FlagOut <=	DPUFlags;
  output <= DPU_Result;
end RTL;
