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
                        ADD, ADDU, ADDI, ADDIU, LUI, SUB, SUBU, CLO, CLZ,
                        -- logical
                        AND_inst, ANDI, OR_inst, ORI, NOR_inst, XOR_inst, XORI, NOP,
                        -- shift and rotate
                        SLL_inst, SRL_inst, SLLV, SRLV,
                        -- jumps and branches
                        J, JR, JAL, JALR, BEQ, BNE,
                        -- multiplication and division
                        MUL, MULT, MULTU,
                        -- Accumulator Access
                        MFHI, MFLO, MTHI, MTLO,
                        -- load and store
                        LB, LBU, LH, LHU, LW, LWL, LWR, SB, SH, SW, SWL, SWR
                        );

    -------------------------------------------------ALU COMMANDS

    TYPE ALU_COMMAND IS (ALU_ADDU  , ALU_SUBU  , ALU_ADD  , ALU_SUB  ,
                         ALU_PASS_A, ALU_PASS_B,
                         ALU_AND   , ALU_OR    , ALU_XOR   , ALU_SLR   ,
                         ALU_SLL   , ALU_NEG_A , ALU_SAR   , ALU_SAL   ,
                         ALU_FLIP_A, ALU_CLR_A ,
                         ALU_NOR   , ALU_COMP  , ALU_CLO   , ALU_CLZ   ,
                         ALU_MULTU , ALU_MULT  , ALU_MTLO  , ALU_MTHI);

    -------------------------------------------------DPU COMMANDS
    TYPE DPU_IN_MUX IS (MEM, CONT, RFILE, ONE);
    -------------------------------------------------DPU COMMANDS FLAGS
    constant DPU_CLEAR_FLAG_WIDTH : integer := 3;
    constant DPU_CLEAR_FLAG_EQ  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "011";
    constant DPU_CLEAR_FLAG_Z   : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "001";
    constant DPU_CLEAR_FLAG_OV  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "010";
    constant DPU_CLEAR_FLAG_C   : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "100";
    constant DPU_CLEAR_NO_FLAG  : std_logic_vector (DPU_CLEAR_FLAG_WIDTH-1 downto 0):= "000";
    ------------------------------------------------
    TYPE RFILE_IN_MUX IS (CU, ACC_HI, ACC_LOW, DPU_HI, DPU_LOW,
                          FROM_MEM8,FROM_MEM16,FROM_MEM32,
                          FROM_MEM8_SGINED, FROM_MEM16_SGINED, ZERO);
    TYPE MEM_IN_MUX IS (RFILE_DATA_1, RFILE_DATA_2, DPU_DATA);

    --constant DPU_COMMAND_WIDTH : integer := 12;

    ------------------------------------------------
    constant ZERO8  :std_logic_vector(7 downto 0)  := "00000000";
    constant ONE8   :std_logic_vector(7 downto 0)  := "11111111";
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
             Command: in ALU_COMMAND;
             OV_out: out std_logic;
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
              Data_in_DPU_LOW    : in std_logic_vector (BitWidth-1 downto 0);
        			Data_in_DPU_HI     : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_ACC_HI     : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_ACC_LOW    : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_sel        : in RFILE_IN_MUX;
              RFILE_in_address   : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
              WB_enable          : in std_logic_vector (3 downto 0);
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
    	  output: out std_logic_vector ( 2*CPU_Bitwidth-1 downto 0)
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
        Mem_RW          : out std_logic_vector (3 downto 0);
        MEM_IN_SEL      : out MEM_IN_MUX;
        ----------------------------------------
        IO_DIR          : out std_logic;
        IO_RD           : in std_logic_vector (BitWidth-1 downto 0);
        IO_WR           : out std_logic_vector (BitWidth-1 downto 0);
        ----------------------------------------
        DPU_Flags       : in  std_logic_vector (3 downto 0);
        DPU_Flags_FF    : in  std_logic_vector (3 downto 0);
        DataToDPU_1     : out std_logic_vector (BitWidth-1 downto 0);
        DataToDPU_2     : out std_logic_vector (BitWidth-1 downto 0);

        DPU_ALUCommand  : out ALU_COMMAND;
        DPU_Mux_Cont_1  : out DPU_IN_MUX;
        DPU_Mux_Cont_2  : out DPU_IN_MUX;
        DPU_SetFlag     : out std_logic_vector (2 downto 0);
        ----------------------------------------
        RFILE_data_sel  : out RFILE_IN_MUX;
    	  RFILE_in_address: out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
        RFILE_WB_enable : out std_logic_vector (3 downto 0);
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

             ALUCommand: in ALU_COMMAND;
             Mux_Cont_1: DPU_IN_MUX;
             Mux_Cont_2: DPU_IN_MUX;
             SetFlag   : in std_logic_vector (2 downto 0);

             DPU_Flags   : out std_logic_vector (3 downto 0);
             DPU_Flags_FF: out std_logic_vector (3 downto 0);
             Result      : out std_logic_vector (2*BitWidth-1 downto 0);
             Result_FF   : out std_logic_vector (2*BitWidth-1 downto 0)
        );
    end component;
    ----------------------------------------
    component Memory is
      generic (BitWidth: integer);
      port ( RdAddress: in std_logic_vector (BitWidth-1 downto 0);
           Data_in: in std_logic_vector (BitWidth-1 downto 0);
  			   WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
           clk: in std_logic;
           RW: in std_logic_vector (3 downto 0);
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
