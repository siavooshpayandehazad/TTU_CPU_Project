library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL; 

entity PicoCPU is
  port(
    rst: in std_logic;
    clk: in std_logic;
	 FlagOut: out std_logic_vector ( 3 downto 0);
	 output: out std_logic_vector ( 7 downto 0)
  );
end PicoCPU;


architecture RTL of PicoCPU is

---------------------------------------------
--      component declaration
---------------------------------------------

  component ControlUnit is
  generic (BitWidth: integer;
           InstructionWidth:integer);  
    port(
      rst: in std_logic;
      clk: in std_logic;        
      Instr_In: in std_logic_vector (InstructionWidth-1 downto 0);
      Instr_Add: out std_logic_vector (BitWidth-1 downto 0);       
      MemRdAddress: out std_logic_vector (BitWidth-1 downto 0);
		MemWrtAddress: out std_logic_vector (BitWidth-1 downto 0);
      Mem_RW: out std_logic;  
      DPU_Flags: in std_logic_vector (3 downto 0);
      DataToDPU: out std_logic_vector (BitWidth-1 downto 0);
      CommandToDPU: out std_logic_vector (10 downto 0);
		Reg_in_sel: out std_logic_vector (7 downto 0);
		Reg_out_sel: out std_logic_vector (2 downto 0); 
      DataFromDPU: in std_logic_vector (BitWidth-1 downto 0)
    );
  end component;
  ----------------------------------------
  component InstMem is
    generic (BitWidth : integer;
           InstructionWidth:integer); 
    port ( address : in std_logic_vector(BitWidth-1 downto 0);
         data : out std_logic_vector(InstructionWidth-1 downto 0) );
  end component;
  ----------------------------------------
  component DPU is
    generic (BitWidth: integer);
    port ( Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         Command: in std_logic_vector (10 downto 0);
			Reg_in_sel: in std_logic_vector (7 downto 0);
			Reg_out_sel: in std_logic_vector (2 downto 0); 
         rst: in std_logic;
         DPU_Flags: out std_logic_vector (3 downto 0);
         Result: out std_logic_vector (BitWidth-1 downto 0) 
  );
  end component;
  ----------------------------------------
  component Mem is
    generic (BitWidth: integer);  
    port ( RdAddress: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
			WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         RW: in std_logic;
         rst: in std_logic;
         Data_Out: out std_logic_vector (BitWidth-1 downto 0) 
    );
  end component;
  
---------------------------------------------
--      constants
---------------------------------------------
constant CPU_Bitwidth : integer := 8;
constant CPU_Instwidth : integer := 6 + CPU_Bitwidth;

---------------------------------------------
--      Signals
---------------------------------------------
signal Instr: std_logic_vector (CPU_Instwidth-1 downto 0);
signal InstrAdd , Mem_Rd_Address,Mem_Wrt_Address, DPUData,MEMDATA,DPU_Result: std_logic_vector (CPU_Bitwidth-1 downto 0) ;
signal MemRW: std_logic;
signal DPUFlags: std_logic_vector (3 downto 0);
signal DPUCommand : std_logic_vector (10 downto 0);
signal Reg_in_sel: std_logic_vector (7 downto 0);
signal Reg_out_sel: std_logic_vector (2 downto 0);

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
  port map (Mem_Rd_Address, DPU_Result,Mem_Wrt_Address, clk,MemRW , rst , MEMDATA);  
  
  FlagOut <=	DPUFlags;
  output <= DPU_Result;
end RTL;
