library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



package pico_cpu is

    constant CPU_Bitwidth  : integer := 32;
    constant CPU_Instwidth : integer := CPU_Bitwidth;
    constant InstMem_depth : integer := 1024;
    constant DataMem_depth : integer := 1024;
    constant RFILE_DEPTH : integer := 32;
    constant RFILE_SEL_WIDTH : integer := 5; --should be log2 of RFILE_DEPTH
    constant clock_period  : time := 1 ns;

    -------------------------------------------------
    TYPE Instruction IS (--arithmetic
                        ADDU, ADDI, ADDIU, LUI, SUBU, CLO, CLZ,
                        -- logical
                        AND_inst, ANDI, OR_inst, ORI, NOR_inst, XOR_inst, XORI, NOP,
                        -- shift and rotate
                        SLL_inst, SRL_inst, SLLV, SRLV,
                        -- jumps and branches
                        J, JR, BEQ,
                        -- multiplication and division
                        MUL, MULT, MULTU
                        );

    -------------------------------------------------ALU COMMANDS
    constant ALU_COMAND_WIDTH : integer := 5;
    constant ALU_ADD    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00000";
    constant ALU_SUB    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00001";
    constant ALU_PASS_A : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00010";
    constant ALU_PASS_B : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00011";
    constant ALU_AND    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00100";
    constant ALU_OR     : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00101";
    constant ALU_XOR    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00110";
    constant ALU_SLR    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "00111";
    constant ALU_SLL    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01000";
    constant ALU_NEG_A  : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01001";
    constant ALU_SAR    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01010";
    constant ALU_SAL    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01011";
    constant ALU_FLIP_A : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01100";
    constant ALU_CLR_A  : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01101";
    constant ALU_RRC    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01110";
    constant ALU_RLC    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "01111";
    constant ALU_NOR    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10000";
    constant ALU_COMP   : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10001";
    constant ALU_CLO    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10010";
    constant ALU_CLZ    : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10011";
    constant ALU_MULTU  : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10100";
    constant ALU_MULT   : std_logic_vector (ALU_COMAND_WIDTH-1 downto 0):= "10101";

    -------------------------------------------------DPU COMMANDS
    constant DPU_DATA_SEL_WIDTH : integer := 2;
    constant DPU_DATA_IN_MEM     : std_logic_vector (DPU_DATA_SEL_WIDTH-1 downto 0):= "00";
    constant DPU_DATA_IN_CONT    : std_logic_vector (DPU_DATA_SEL_WIDTH-1 downto 0):= "01";
    constant DPU_DATA_IN_RFILE   : std_logic_vector (DPU_DATA_SEL_WIDTH-1 downto 0):= "10";
    constant DPU_DATA_IN_ONE     : std_logic_vector (DPU_DATA_SEL_WIDTH-1 downto 0):= "11";
    -------------------------------------------------DPU COMMANDS FLAGS
    constant DPU_CLEAR_FLAG_WIDTH : integer := 3;
    constant DPU_CLEAR_FLAG_EQ  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "011";
    constant DPU_CLEAR_FLAG_Z   : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "001";
    constant DPU_CLEAR_FLAG_OV  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "010";
    constant DPU_CLEAR_FLAG_C   : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "100";
    constant DPU_CLEAR_NO_FLAG  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "000";
    ------------------------------------------------
    constant RFLILE_SEL_WIDTH: integer  := 2;
    constant RFILE_IN_ACC_LOW  : std_logic_vector (RFLILE_SEL_WIDTH-1 downto 0):= "00";
    constant RFILE_IN_CU       : std_logic_vector (RFLILE_SEL_WIDTH-1 downto 0):= "01";
    constant RFILE_IN_ACC_HI   : std_logic_vector (RFLILE_SEL_WIDTH-1 downto 0):= "10";
    constant RFILE_IN_MEM      : std_logic_vector (RFLILE_SEL_WIDTH-1 downto 0):= "11";

    constant DPU_COMMAND_WIDTH : integer := 11;

    ------------------------------------------------
    constant ZERO14 :std_logic_vector(13 downto 0) := "00000000000000";
    constant ONE14  :std_logic_vector(13 downto 0) := "11111111111111";
    constant ZERO16 :std_logic_vector(15 downto 0) := "0000000000000000";
    constant ONE16  :std_logic_vector(15 downto 0) := "1111111111111111";
    constant ZERO32 :std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    constant ONE32  :std_logic_vector(31 downto 0) := "11111111111111111111111111111111";

    component GPIO is
      generic (BitWidth: integer);
      port ( IO_sel:  in    std_logic;
             IO: inout std_logic_vector (BitWidth-1 downto 0);
             WrtData: in    std_logic_vector (BitWidth-1 downto 0);
             RdData:  out   std_logic_vector (BitWidth-1 downto 0)
        );
    end component;

    component ALU is
      generic (BitWidth: integer);
      port ( A: in std_logic_vector (BitWidth-1 downto 0);
             B: in std_logic_vector (BitWidth-1 downto 0);
             Command: in std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
             Cflag_in: in std_logic;
             Cflag_out: out std_logic;
             Result: out std_logic_vector (2*BitWidth-1 downto 0)
        );
    end component;

    component RegisterFile is
      generic (BitWidth: integer);
        port ( clk : in std_logic;
              rst: in std_logic;
              Data_in_mem        : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_CU         : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_ACC_HI     : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_ACC_LOW    : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_sel        : in std_logic_vector (1 downto 0);
              Register_in_sel    : in std_logic_vector (RFILE_SEL_WIDTH downto 0);
              Register_out_sel_1 : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
              Register_out_sel_2 : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
              Data_out_1         : out std_logic_vector (BitWidth-1 downto 0);
              Data_out_2         : out std_logic_vector (BitWidth-1 downto 0)
        );
    end component;

    component PicoCPU is
      port(
        rst: in std_logic;
        clk: in std_logic;
    	  FlagOut: out std_logic_vector ( 3 downto 0);
        IO: inout std_logic_vector (CPU_Bitwidth-1 downto 0);
    	  output: out std_logic_vector ( CPU_Bitwidth-1 downto 0)
      );
    end component;

    component ControlUnit is
      generic (BitWidth: integer;
               InstructionWidth: integer);
      port(
        rst             : in  std_logic;
        clk             : in  std_logic;
        ----------------------------------------
        Instr_In        : in  std_logic_vector (InstructionWidth-1 downto 0);
        Instr_Add       : out std_logic_vector (BitWidth-1 downto 0);
        ----------------------------------------
        MemRdAddress    : out std_logic_vector (BitWidth-1 downto 0);
    	  MemWrtAddress   : out std_logic_vector (BitWidth-1 downto 0);
        Mem_RW          : out std_logic;
        ----------------------------------------
        IO_DIR          : out std_logic;
        IO_RD           : in std_logic_vector (BitWidth-1 downto 0);
        IO_WR           : out std_logic_vector (BitWidth-1 downto 0);
        ----------------------------------------
        DPU_Flags       : in  std_logic_vector (3 downto 0);
        DPU_Flags_FF    : in  std_logic_vector (3 downto 0);
        DataToDPU       : out std_logic_vector (BitWidth-1 downto 0);

        DPU_ALUCommand  : out std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
        DPU_Mux_Cont_1  : out std_logic_vector (1 downto 0);
        DPU_Mux_Cont_2  : out std_logic_vector (1 downto 0);
        DPU_SetFlag     : out std_logic_vector (2 downto 0);
        ----------------------------------------
        RFILE_data_sel  : out std_logic_vector (1 downto 0);
    	  RFILE_in_sel    : out std_logic_vector (RFILE_SEL_WIDTH downto 0);
    	  RFILE_out_sel_1 : out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
    	  RFILE_out_sel_2 : out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
        Data_to_RFILE   :  out std_logic_vector (BitWidth-1 downto 0);
        ----------------------------------------
    	  flush_pipeline  : out std_logic;
        DPU_RESULT      : in std_logic_vector (2*BitWidth-1 downto 0);
        DPU_RESULT_FF   : in  std_logic_vector (2*BitWidth-1 downto 0)
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
      port (
             rst: in std_logic;
             clk: in std_logic;

             Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
             Data_in_RegFile_1: in std_logic_vector (BitWidth-1 downto 0);
             Data_in_RegFile_2: in std_logic_vector (BitWidth-1 downto 0);
             Data_in_control_1: in std_logic_vector (BitWidth-1 downto 0);
             Data_in_control_2: in std_logic_vector (BitWidth-1 downto 0);

             ALUCommand: in std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
             Mux_Cont_1: in std_logic_vector (1 downto 0);
             Mux_Cont_2: in std_logic_vector (1 downto 0);
             SetFlag   : in std_logic_vector (2 downto 0);

             DPU_Flags   : out std_logic_vector (3 downto 0);
             DPU_Flags_FF: out std_logic_vector (3 downto 0);
             Result      : out std_logic_vector (2*BitWidth-1 downto 0);
             Result_FF   : out std_logic_vector (2*BitWidth-1 downto 0)
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
