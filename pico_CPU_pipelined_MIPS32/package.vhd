--Copyright (C) 2017 Siavoosh Payandeh Azad

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
                        SLL_inst, SRL_inst, SLLV, SRLV, SRA_inst, SRAV,
                        -- jumps and branches
                        J, JR, JAL, JALR, BEQ, BNE, BGEZ, BGEZAL, BLEZ, BGTZ, BLTZ, BLTZAL,
                        -- multiplication and division
                        MUL, MULT, MULTU, MADD, MADDU, MSUB, MSUBU, DIV, DIVU,
                        -- Accumulator Access
                        MFHI, MFLO, MTHI, MTLO,
                        -- load and store
                        LB, LBU, LH, LHU, LW, LWL, LWR, SB, SH, SW, SWL, SWR,
                        -- conditional move
                        MOVZ, MOVN, SLT, SLTI, SLTIU, SLTU,
                        -- exception
                        SYSCALL, ERET,
                        -- Co-processor
                        MFC0, MTC0
                        );

    -------------------------------------------------ALU COMMANDS

    TYPE ALU_COMMAND IS (ALU_ADDU,   ALU_SUBU,  ALU_ADD  , ALU_SUB,
                         ALU_PASS_A,
                         ALU_AND,    ALU_OR,    ALU_XOR   , ALU_SLR,
                         ALU_SLL,    ALU_SAR   , ALU_SAL,
                         ALU_NOR,    ALU_COMP,  ALU_CLO   , ALU_CLZ,
                         ALU_EQ_Z,   ALU_EQ,    ALU_COMP_EQ, ALU_COMPU,
                         ALU_MULTU,  ALU_MULT,  ALU_MTHI, ALU_MTLO,
                         ALU_MADD,   ALU_MADDU, ALU_MSUB, ALU_MSUBU,
                         ALU_DIV, ALU_DIVU);

    -------------------------------------------------DPU COMMANDS
    TYPE DPU_IN_MUX IS (MEM, CONT, RFILE, ONE);

    ------------------------------------------------
    TYPE RFILE_IN_MUX IS (CU, ACC_HI, ACC_LOW, DPU_LOW, R2,
                          FROM_MEM8,FROM_MEM16,FROM_MEM32,
                          FROM_MEM8_SGINED, FROM_MEM16_SGINED,
                          ZERO);
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
              Data_in_ACC_HI     : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_ACC_LOW    : in std_logic_vector (BitWidth-1 downto 0);
              Data_in_R2         : in std_logic_vector (BitWidth-1 downto 0);
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
      generic (Mem_preload_file: string :="code.txt");
      port(
        rst: in std_logic;
        clk: in std_logic;
        IO: inout std_logic_vector (CPU_Bitwidth-1 downto 0)
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
        DPU_OV          : in  std_logic;
        DataToDPU_2     : out std_logic_vector (BitWidth-1 downto 0);

        DPU_ALUCommand  : out ALU_COMMAND;
        DPU_Mux_Cont_2  : out DPU_IN_MUX;
        ----------------------------------------
        RFILE_data_sel  : out RFILE_IN_MUX;
    	RFILE_in_address: out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
        RFILE_WB_enable : out std_logic_vector (3 downto 0);
    	RFILE_out_sel_1 : out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
    	RFILE_out_sel_2 : out std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
        Data_to_RFILE   :  out std_logic_vector (BitWidth-1 downto 0);
        ----------------------------------------
        DPU_RESULT      : in std_logic_vector (2*BitWidth-1 downto 0);
        DPU_RESULT_FF   : in  std_logic_vector (2*BitWidth-1 downto 0)
      );
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
             Data_in_control_2: in std_logic_vector (BitWidth-1 downto 0);
             ALUCommand: in ALU_COMMAND;
             Mux_Cont_2: DPU_IN_MUX;
             DPU_OV      : out std_logic;
             Result      : out std_logic_vector (2*BitWidth-1 downto 0);
             Result_FF   : out std_logic_vector (2*BitWidth-1 downto 0)
        );
    end component;
    ----------------------------------------
    component RAM is
      generic (BitWidth: integer;
               preload_file: string :="code.txt");
      port ( RdAddress_1: in std_logic_vector (BitWidth-1 downto 0);
             RdAddress_2: in std_logic_vector (BitWidth-1 downto 0);
             Data_in: in std_logic_vector (BitWidth-1 downto 0);
    			   WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
             clk: in std_logic;
             RW: in std_logic_vector(3 downto 0);
             rst: in std_logic;
             Data_Out_1: out std_logic_vector (BitWidth-1 downto 0);
             Data_Out_2: out std_logic_vector (BitWidth-1 downto 0)
        );
    end component;

end; --package body
