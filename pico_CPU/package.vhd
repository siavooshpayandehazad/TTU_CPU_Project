library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



package pico_cpu is

    constant CPU_Bitwidth  : integer := 32;
    constant CPU_Instwidth : integer := 6 + CPU_Bitwidth;
    constant InstMem_depth : integer := 1024;
    constant DataMem_depth : integer := 1024;
    constant clock_period  : time := 1 ns;

    component ALU is
      generic (BitWidth: integer);
      port ( A: in std_logic_vector (BitWidth-1 downto 0);
            B: in std_logic_vector (BitWidth-1 downto 0);
            Command: in std_logic_vector (3 downto 0);
            Cflag_in: in std_logic;
            Cflag_out: out std_logic;
            Result: out std_logic_vector (BitWidth-1 downto 0)
        );
    end component;

    component RegisterFile is
    generic (BitWidth: integer);
      port ( clk : in std_logic;
    			rst: in std_logic;
    			Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
    			Data_in_CU: in std_logic_vector (BitWidth-1 downto 0);
    			Data_in_ACC: in std_logic_vector (BitWidth-1 downto 0);
    			Data_in_sel: in std_logic_vector (1 downto 0);
    			Register_in_sel: in std_logic_vector (7 downto 0);
    			Register_out_sel: in std_logic_vector (2 downto 0);
    			Data_out: out std_logic_vector (BitWidth-1 downto 0)
      );
    end component;

    component PicoCPU is
      port(
        rst: in std_logic;
        clk: in std_logic;
    	 FlagOut: out std_logic_vector ( 3 downto 0);
    	 output: out std_logic_vector ( CPU_Bitwidth-1 downto 0)
      );
    end component;

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

    component  Adder_Sub is
      generic (BitWidth: integer);
      port (
            A: in std_logic_vector (BitWidth-1 downto 0);
            B: in std_logic_vector (BitWidth-1 downto 0);
            Add_Sub: in std_logic;
            result: out std_logic_vector (BitWidth-1 downto 0);
            Cout: out std_logic
        );
    end component;

    component FullAdderSub is
      Port ( C_in : in  STD_LOGIC;
             A : in  STD_LOGIC;
             B : in  STD_LOGIC;
       Add_Sub: in STD_LOGIC;
             C_out : out  STD_LOGIC;
             Sum : out  STD_LOGIC);
  end component;

end; --package body
