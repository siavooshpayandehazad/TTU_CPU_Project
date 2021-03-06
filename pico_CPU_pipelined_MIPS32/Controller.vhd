--Copyright (C) 2017 Siavoosh Payandeh Azad

library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.pico_cpu.all;
-- There are 4 stages of pipeline:
--      * Fetch: we read the instruction from memory, since the memory will respond in 1
--               clock cycle, we need to pass the input of the PC register to be on time!
--      * Decode/REGFILE: here we extract the registers used by the instructions
--      * Execute: we execute ALU operations here
--      * WB: we write into the REGFILE, in cases that we read from Memory and want to write into REGFILE,
--            since the ALU generates the address, We will write into the REGFILE during WB but the value
--            be inside the register in the next clock cycle, however, the REGFILE has a bypass mechanism
--            that can push this value to output as soon as it gets it!
-----------------------------------
-- Regarding the jumps, we assume that the compiler always executes 1 instruction
-- after the jump!


entity ControlUnit is
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
    Result_ACC   : in  std_logic_vector (2*BitWidth-1 downto 0)
  );
end ControlUnit;


architecture RTL of ControlUnit is

  ---------------------------------------------
  --      Signals and Types
  ---------------------------------------------
  signal Instr_F, Instr_D, Instr_E, Instr_WB :Instruction := NOP;

  signal PC_in, PC_out : std_logic_vector (BitWidth-1 downto 0):= (others => '0');
  signal PC_jmp_in, PC_jmp_out : std_logic_vector (BitWidth-1 downto 0):= (others => '0');

  signal InstrReg_out_D, InstrReg_out_E, InstrReg_out_WB: std_logic_vector (InstructionWidth-1 downto 0) := (others => '0');
  signal arithmetic_operation : std_logic;
  signal IO_WR_in, IO_WR_in_FF : std_logic_vector(BitWidth-1 downto 0);
  signal IO_DIR_in, IO_DIR_FF :std_logic;
  signal address_error  : std_logic;
  signal Illigal_opcode : std_logic;

  signal flush_F,flush_F2, flush_D : std_logic;
  signal trap : std_logic;

  type RFILE_type is array (0 to 31) of std_logic_vector(BitWidth-1 downto 0) ;
  signal cp0_control, cp0_control_in : RFILE_type := ((others=> (others=>'0')));

  signal LOW_FF  : std_logic_vector (BitWidth-1 downto 0);
  ---------------------------------------------
  --    Aliases
  ---------------------------------------------
  alias LOW  : std_logic_vector is DPU_RESULT(31 downto 0);
  alias HIGH : std_logic_vector is DPU_RESULT(63 downto 32);

  alias SPECIAL_F   : std_logic_vector (5 downto 0) is Instr_In (31 downto 26);
  alias opcode_F    : std_logic_vector (5 downto 0) is Instr_In (5 downto 0);
  alias MF          : std_logic_vector (4 downto 0) is Instr_In (25 downto 21);
  alias BRANCH_FIELD: std_logic_vector (4 downto 0) is Instr_In (20 downto 16);

  alias rs_wb : std_logic_vector (4 downto 0) is InstrReg_out_WB (25 downto 21);
  alias rt_wb : std_logic_vector (4 downto 0) is InstrReg_out_WB (20 downto 16);
  alias rd_wb : std_logic_vector (4 downto 0) is InstrReg_out_WB (15 downto 11);

  alias rs_ex : std_logic_vector (4 downto 0) is InstrReg_out_E (25 downto 21);
  alias rt_ex : std_logic_vector (4 downto 0) is InstrReg_out_E (20 downto 16);
  alias rd_ex : std_logic_vector (4 downto 0) is InstrReg_out_E (15 downto 11);
  alias sa_ex : std_logic_vector (4 downto 0) is InstrReg_out_E (10 downto 6);

  alias rs_d : std_logic_vector (4 downto 0) is InstrReg_out_D (25 downto 21);
  alias rt_d : std_logic_vector (4 downto 0) is InstrReg_out_D (20 downto 16);
  alias rd_d : std_logic_vector (4 downto 0) is InstrReg_out_D (15 downto 11);

  alias INST_INDEX_EX : std_logic_vector (25 downto 0) is InstrReg_out_E (25 downto 0);
  alias IMMEDIATE_EX : std_logic_vector (15 downto 0) is InstrReg_out_E (15 downto 0);
  alias OFFSET_EX : std_logic_vector (15 downto 0) is InstrReg_out_E (15 downto 0);
  alias BASE_D   : std_logic_vector (4 downto 0) is InstrReg_out_D (25 downto 21);

  alias SR    : std_logic_vector (BitWidth-1 downto 0) is cp0_control(12);
  alias Cause : std_logic_vector (BitWidth-1 downto 0) is cp0_control(13);
  alias EPC   : std_logic_vector (BitWidth-1 downto 0) is cp0_control(14);

begin
---------------------------------------------
-- Clock Process
---------------------------------------------
CLOCK_PROC:process (clk,rst)
    begin
    if rst = '1' then
       PC_out <= ZERO32-4;
       InstrReg_out_D <= (others=> '0');
       InstrReg_out_E <= (others=> '0');
       InstrReg_out_WB <= (others=> '0');
       Instr_D <= NOP;
       Instr_E <= NOP;
       Instr_WB <= NOP;
       IO_WR_in_FF <=  (others=> '0');
       IO_DIR_FF <= '0';
       cp0_control <= ((others=> (others=>'0')));
       PC_jmp_out <= (others=> '0');
       LOW_FF <= (others=> '0');
    elsif clk'event and clk='1' then
       IO_WR_in_FF <= IO_WR_in;
       IO_DIR_FF <= IO_DIR_in;
       PC_out <= PC_in;
       InstrReg_out_D <= Instr_In;
       InstrReg_out_E <= InstrReg_out_D;
       InstrReg_out_WB <= InstrReg_out_E;
       Instr_D <= Instr_F;
       Instr_E <= Instr_D;
       if flush_F = '1' or flush_F2 = '1' then
          Instr_D <= NOP;
          InstrReg_out_D <= (others => '0');
       end if;
       if flush_D = '1' then
          Instr_E <= NOP;
          InstrReg_out_E <= (others => '0');
       end if;
       Instr_WB <= Instr_E;
       cp0_control <= cp0_control_in;
       PC_jmp_out <=  PC_jmp_in;
       LOW_FF <= LOW;
  end if;
end process;

-- PC_in is used since we are using the same RAM for Instruction as well! (it returns the data after 1 clk)
Instr_Add <= PC_in;
--------------------------------------------------------------------------------
--GPIO STUFF
--------------------------------------------------------------------------------
-- TODO: we need to map the IO-regs somewhere!
IO_DIR <= IO_DIR_FF;
IO_WR <= IO_WR_in_FF;

--------------------------------------------------------------------------------
--Exception handling
--------------------------------------------------------------------------------
EXCEPTION_HANDLING: process(DPU_OV, PC_out, cp0_control, Instr_E,
                             Illigal_opcode)begin
    flush_F <= '0';
    flush_D <= '0';
    cp0_control_in(12) <= cp0_control(12); --SR
    cp0_control_in(13) <= cp0_control(13); --Cause
    cp0_control_in(14) <= cp0_control(14); --EPC
    if Illigal_opcode = '1' then
      cp0_control_in(14) <= PC_out;      --EPC <= PC
      cp0_control_in(13)(1 downto 0) <="01";  --cause register
      cp0_control_in(12) <= std_logic_vector(shift_left(unsigned(cp0_control(12)), 4));
      flush_F <= '1';   -- we flush the Fetch
    end if;

    if DPU_OV = '1' and (Instr_E = ADD or Instr_E = ADDI or Instr_E = SUB)then
      cp0_control_in(14) <= PC_out;      --EPC <= PC
      cp0_control_in(13)(1 downto 0) <="10";  --cause register
      cp0_control_in(12) <= std_logic_vector(shift_left(unsigned(cp0_control(12)), 4));
      flush_F <= '1';   -- we flush the Fetch
      flush_D <= '1';   -- here we flush the decode stage (it will be replaced with )
    end if;

    if Instr_E = SYSCALL then
      cp0_control_in(14) <= PC_out;     --EPC <= PC
      cp0_control_in(13)(1 downto 0) <="11"; --cause register
      cp0_control_in(12) <= std_logic_vector(shift_left(unsigned(cp0_control(12)), 4)); --status_reg
      flush_F <= '1';   -- we flush the Fetch
      flush_D <= '1';   -- here we flush the decode stage (it will be replaced with )
    end if;

    if Instr_E = ERET then
      cp0_control_in(12) <= std_logic_vector(shift_right(unsigned(cp0_control(12)), 4)); --status_reg
    end if;

    if Instr_E = MTC0 then
        cp0_control_in(to_integer(unsigned(rd_wb))) <= LOW;
    end if;
end process;

--------------------------------------------------------------------------------
--Instruction Decoding
--------------------------------------------------------------------------------
DEC_SIGNALS_GEN: process(Instr_D, rs_ex, rt_ex)
    begin

    RFILE_out_sel_1 <= (others => '0');
    RFILE_out_sel_2 <= (others => '0');
    -----------------------Arithmetic-------------------------------------------
    if Instr_D = ADD or Instr_D = ADDU or Instr_D = SUB or Instr_D = SUBU  then
          RFILE_out_sel_1  <=  rs_d;
      RFILE_out_sel_2  <=  rt_d;
    elsif Instr_D = ADDI or Instr_D = ADDIU or  Instr_D = CLO or Instr_D = CLZ then
          RFILE_out_sel_1  <=  rs_d;
    	  RFILE_out_sel_2  <=  rs_d;
     -----------------------LOGICAL---------------------------------------------
    elsif Instr_D = AND_inst or Instr_D = OR_inst or Instr_D = NOR_inst or Instr_D = XOR_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;
    elsif Instr_D = ANDI or Instr_D = ORI or Instr_D = XORI then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;
    -----------------------SHIFT AND ROTATE-------------------------------------
    elsif Instr_D = SLL_inst or Instr_D = SRL_inst or Instr_D = SRA_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rt_d;
    elsif Instr_D = SLLV or Instr_D = SRLV or Instr_D = SRAV then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;
    -----------------------JUMP and BRANCH--------------------------------------
    elsif Instr_D = J or Instr_D = JAL or Instr_D = JALR or Instr_D = JR or
          Instr_D = BEQ or Instr_D = BNE or Instr_D = BGEZ or Instr_D = BGEZAL or
          Instr_D = BLEZ or Instr_D = BGTZ or Instr_D =  BLTZ or Instr_D = BLTZAL then

          if Instr_D = JALR or Instr_D = JR or Instr_D = BGEZ or Instr_D = BGEZAL
             or Instr_D = BGTZ    then
                RFILE_out_sel_1  <=  rs_d;
                RFILE_out_sel_2  <=  rs_d;
          elsif Instr_D = BEQ  or Instr_D = BNE then
                RFILE_out_sel_1  <=  rt_d;
                RFILE_out_sel_2  <=  rs_d;
          elsif Instr_D = BLEZ or Instr_D = BLTZ or Instr_D = BLTZAL then
          		RFILE_out_sel_1  <=  "00000"; -- we use R0 here!
                RFILE_out_sel_2  <=  rs_d;
          end if;
    -----------------------MULTIPLICATION AND DIVISION--------------------------
    elsif Instr_D = MULTU or Instr_D = MULT or Instr_D = MUL or Instr_D = DIV or
        Instr_D = DIVU or Instr_D = MADD  or Instr_D = MADDU or Instr_D = MSUB or
        Instr_D = MSUBU then
         RFILE_out_sel_1  <=  rt_d;
         RFILE_out_sel_2  <=  rs_d;
    ----------------------ACCUMULATOR ACCESS -----------------------------------
    elsif Instr_D = MTHI or Instr_D = MTLO then
        RFILE_out_sel_1  <=  rs_d;
        RFILE_out_sel_2  <=  rs_d;
    ----------------------LOAD AND STORE ---------------------------------------
    elsif Instr_D = LB or Instr_D = LBU or Instr_D = LH or Instr_D = LHU or
        Instr_D = LW or Instr_D = LWL  or Instr_D = LWR then
        RFILE_out_sel_1  <=  BASE_D;
        RFILE_out_sel_2  <=  BASE_D;
    elsif Instr_D = SB or Instr_D = SH  or Instr_D = SW or Instr_D = SWL or
          Instr_D = SWR then
        RFILE_out_sel_1  <=  BASE_D;
        RFILE_out_sel_2  <=  rt_d;
      ----------------------conditional move -----------------------------------
    elsif Instr_D = SLT or Instr_D = SLTU then
        RFILE_out_sel_1  <=  rt_d;
        RFILE_out_sel_2  <=  rs_d;
    elsif Instr_D = MOVN or Instr_D = MOVZ then
        RFILE_out_sel_1  <=  rt_d;
        RFILE_out_sel_2  <=  "00000";	-- we use R0 here!
    elsif Instr_D = SLTI or Instr_D = SLTIU then
        RFILE_out_sel_1  <=  rs_d;
        RFILE_out_sel_2  <=  rs_d;
    ------------------------CO-PROCESSOR 0--------------------------------------
    elsif Instr_D =  MTC0 then
        RFILE_out_sel_1  <=  rt_d;
        RFILE_out_sel_2  <=  rt_d;
    -----------------------SYSCALL AND TRAPS------------------------------------
    elsif Instr_D = SYSCALL then
        RFILE_out_sel_1  <=  "00010";
        RFILE_out_sel_2  <=  "00010";
    elsif Instr_D =  TEQ or Instr_D = TGE or Instr_D = TGEU then
        RFILE_out_sel_1  <=  rs_d;
        RFILE_out_sel_2  <=  rt_d;
    elsif Instr_D = TGEI or Instr_D = TGEIU or Instr_D = TEQI then
        RFILE_out_sel_1  <=  rs_d;
        RFILE_out_sel_2  <=  rs_d;
    end if;
end process;

--------------------------------------------------------------------------------
--Execution
--------------------------------------------------------------------------------
EX_SIGNALS_GEN:process(Instr_E, IMMEDIATE_EX, DPU_RESULT)
    begin
    -- DO NOT CHANGE THE DEFAULT VALUES!
    trap <= '0';
    address_error <= '0';
    MemWrtAddress  <= (others => '0');
    MemRdAddress   <= (others => '0');
    Mem_RW <= "0000";
    DataToDPU_2 <= (others => '0');
    DPU_ALUCommand <= ALU_PASS_A;
    DPU_Mux_Cont_2 <= RFILE;
    -----------------------Arithmetic-------------------------------------------
    if Instr_E = ADD then
        DPU_ALUCommand <= ALU_ADD;
    elsif Instr_E = ADDU then
        DPU_ALUCommand <= ALU_ADDU;
    elsif Instr_E = SUBU then
        DPU_ALUCommand <= ALU_SUBU;
    elsif Instr_E = SUB then
        DPU_ALUCommand <= ALU_SUB;
    elsif Instr_E = ADDI then
        DPU_ALUCommand <= ALU_ADD;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & IMMEDIATE_EX;
        if IMMEDIATE_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        end if;
    elsif Instr_E = ADDIU then
        DPU_ALUCommand <= ALU_ADDU;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & IMMEDIATE_EX;
        if IMMEDIATE_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        end if;
    elsif Instr_E = LUI then  	-- RFILE by default is giving R0 out
    	DPU_ALUCommand <= ALU_OR;	-- we OR the data from control unit with 0
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= IMMEDIATE_EX & ZERO16;
    elsif Instr_E = CLO then
        DPU_ALUCommand <= ALU_CLO;
    elsif Instr_E = CLZ  then
        DPU_ALUCommand <= ALU_CLZ;
    -----------------------SHIFT AND ROTATE-------------------------------------
    elsif Instr_E = SLL_inst or Instr_E = SRL_inst or Instr_E = SRA_inst then
        DataToDPU_2 <= ZERO16 & "00000000000" & sa_ex;
        DPU_Mux_Cont_2 <= CONT;
        case( Instr_E ) is
          when SLL_inst => DPU_ALUCommand <= ALU_SLL;
          when SRL_inst => DPU_ALUCommand <= ALU_SLR;
          when others => DPU_ALUCommand <= ALU_SAR; --  Instr_E = SRA_inst
        end case;
    elsif Instr_E = SLLV or Instr_E = SRLV or Instr_E = SRAV then
        case( Instr_E ) is
          when SLLV => DPU_ALUCommand <= ALU_SLL;
          when SRLV => DPU_ALUCommand <= ALU_SLR;
          when others => DPU_ALUCommand <= ALU_SAR; -- Instr_E =  SRAV
        end case;
    -----------------------LOGICAL----------------------------------------------
    elsif Instr_E = ANDI or Instr_E = ORI or Instr_E = XORI then
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        case( Instr_E ) is
          when ORI  => DPU_ALUCommand <= ALU_OR;
          when ANDI => DPU_ALUCommand <= ALU_AND;
          when others => DPU_ALUCommand <= ALU_XOR; --Instr_E = XORI
        end case;
    elsif Instr_E = AND_inst then
        DPU_ALUCommand <= ALU_AND;
    elsif Instr_E = OR_inst then
        DPU_ALUCommand <= ALU_OR;
    elsif Instr_E = NOR_inst then
        DPU_ALUCommand <= ALU_NOR;
    elsif Instr_E = XOR_inst then
        DPU_ALUCommand <= ALU_XOR;
    -----------------------JUMP and BRANCH--------------------------------------
    elsif Instr_E = BEQ or Instr_E = BNE then
        DPU_ALUCommand <= ALU_EQ;
    elsif Instr_E = BGTZ or (Instr_E = BGEZ  or Instr_E = BGEZAL)then
        case( Instr_E ) is
            when BGTZ => DPU_ALUCommand <= ALU_COMP;
            when others =>   DPU_ALUCommand <= ALU_COMP_EQ;  --BGEZ or BGEZAL
        end case;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= (others => '0');

    elsif Instr_E = BLEZ or Instr_E = BLTZ or Instr_E = BLTZAL then
        case( Instr_E ) is
            when BLEZ => DPU_ALUCommand <= ALU_COMP_EQ;
            when others =>   DPU_ALUCommand <= ALU_COMP; --BLTZ  or BLTZAL
        end case;
    ---------------CONDITION TESTING AND CONDITIONAL MOVE-----------------------
    elsif Instr_E = MOVN or Instr_E = MOVZ then
        DPU_ALUCommand <= ALU_EQ;
    elsif Instr_E = SLT then
        DPU_ALUCommand <= ALU_COMP;
    elsif Instr_E = SLTI then
        DPU_ALUCommand <= ALU_COMP;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & IMMEDIATE_EX;
        if IMMEDIATE_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        end if;
    elsif Instr_E = SLTU then
        DPU_ALUCommand <= ALU_COMPU;
    elsif Instr_E = SLTIU then
        DPU_ALUCommand <= ALU_COMPU;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & IMMEDIATE_EX;
        if IMMEDIATE_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        end if;
    -----------------------MULTIPLICATION AND DIVISION--------------------------
    elsif Instr_E = MULTU or Instr_E = MULT or Instr_E = MUL or
          Instr_E = DIV or Instr_E = DIVU or Instr_E = MADD  or
          Instr_E = MADDU or Instr_E = MSUB or Instr_E = MSUBU then

        case( Instr_E ) is
          when MULTU => DPU_ALUCommand <= ALU_MULTU;
          when MUL   => DPU_ALUCommand <= ALU_MULT;
          when MULT  => DPU_ALUCommand <= ALU_MULT;
          when MADD  => DPU_ALUCommand <= ALU_MADD;
          when MADDU => DPU_ALUCommand <= ALU_MADDU;
          when MSUB  => DPU_ALUCommand <= ALU_MSUB;
          when MSUBU => DPU_ALUCommand <= ALU_MSUBU;
          when DIV   => DPU_ALUCommand <= ALU_DIV;
          when others => DPU_ALUCommand <= ALU_DIVU; -- Instr_E = DIVU
        end case;
    ----------------------ACCUMULATOR ACCESS -----------------------------------
    elsif Instr_E = MTLO then
        DPU_ALUCommand <= ALU_MTLO;
    elsif Instr_E = MTHI then
        DPU_ALUCommand <= ALU_MTHI;
    ----------------------LOAD -------------------------------------------------
    elsif Instr_E = LBU or Instr_E = LHU or Instr_E = LW  or
          Instr_E = LWL or Instr_E = LWR then
        DPU_ALUCommand <= ALU_ADDU;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & OFFSET_EX;
        if OFFSET_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & OFFSET_EX;
        end if;
        MemRdAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);

    elsif Instr_E = LB or Instr_E = LH then
        DPU_ALUCommand <= ALU_ADD;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & OFFSET_EX;
        if OFFSET_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & OFFSET_EX;
        end if;
        MemRdAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);
    ------------------------store-----------------------------------------------
    elsif Instr_E = SB or Instr_E = SH or Instr_E = SW  or Instr_E = SWL
          or Instr_E = SWR then
        DPU_ALUCommand <= ALU_ADDU;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & OFFSET_EX;
        if OFFSET_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & OFFSET_EX;
        end if;

        -- Address Error Generration!
        if (Instr_E = SH) and DPU_RESULT(0) /= '0' then
          address_error <= '1';
        elsif (Instr_E = SW) and DPU_RESULT(1 downto 0) /= "00" then
          address_error <= '1';
        end if;

        MemWrtAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);
        MEM_IN_SEL <= RFILE_DATA_2;
        case( Instr_E ) is
          when SB => Mem_RW <= "0001";
          when SH => Mem_RW <= "0011";
          when SW => Mem_RW <= "1111";
          when SWL => Mem_RW <= "1100";
          when others => Mem_RW <= "0011"; -- Instr_E = SWR
        end case;
    -------------------Co-Processor 0 and SYSCALL-------------------------------
    elsif Instr_E =  MTC0 or Instr_E = SYSCALL then
        DPU_ALUCommand <= ALU_PASS_A;
    -------------------------------TRAPS----------------------------------------
    elsif Instr_E = TEQ or Instr_E = TGE or Instr_E = TGEU then
        case( Instr_E ) is
          when TEQ  => DPU_ALUCommand <= ALU_EQ;
          when TGE  => DPU_ALUCommand <= ALU_COMP_EQ;
          when others => DPU_ALUCommand <= ALU_COMP_EQU; --TGEU
        end case;
        if LOW = ONE32 then
            trap <= '1';
        end if;
    elsif  Instr_E = TGEI or Instr_E = TGEIU or Instr_E = TEQI then
        case( Instr_E ) is
          when TGEI => DPU_ALUCommand <= ALU_COMP;
          when TGEIU => DPU_ALUCommand <= ALU_COMPU;
          when others => DPU_ALUCommand <= ALU_EQ; -- TEQI
        end case;
        DPU_Mux_Cont_2 <= CONT;
        DataToDPU_2 <= ONE16 & IMMEDIATE_EX;
        if IMMEDIATE_EX(15) = '0' then
          DataToDPU_2 <= ZERO16 & IMMEDIATE_EX;
        end if;
        if LOW = ONE32 then
            trap <= '1';
        end if;
    end if;
end process;

--------------------------------------------------------------------------------
--WRITE BACK
--------------------------------------------------------------------------------
 WB_SIGNALS_GEN: process(Instr_WB,  rt_wb, PC_out, LOW,PC_jmp_out)
      begin
      -- DO NOT CHANGE THE DEFAULT VALUES!
      RFILE_in_address   <= (others => '0');
      RFILE_data_sel <= DPU_LOW;
      Data_to_RFILE  <= (others => '0');
      RFILE_WB_enable <= "0000";
      -----------------------Arithmetic-----------------------------------------
      if Instr_WB = ADD or Instr_WB = ADDU or Instr_WB = SUB or Instr_WB = SUBU
         or Instr_WB = CLO or Instr_WB = CLZ then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      elsif Instr_WB = ADDI or Instr_WB = ADDIU or Instr_WB = LUI then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      -----------------------logical--------------------------------------------
      elsif Instr_WB = AND_inst or Instr_WB = OR_inst or Instr_WB = NOR_inst
            or Instr_WB = XOR_inst then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;

      elsif Instr_WB = ANDI or Instr_WB = ORI or Instr_WB = XORI then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      -----------------------SHIFT AND ROTATE-----------------------------------
      elsif Instr_WB = SLL_inst or Instr_WB = SRL_inst or Instr_WB = SLLV or
            Instr_WB = SRLV or Instr_WB = SRA_inst or Instr_WB = SRAV then
            RFILE_WB_enable <= "1111";
            RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      -----------------------MULTIPLICATION AND DIVISION------------------------
      --  MULT and MULTU, MADD, MADDU, DIV and DIVU only WRITES IN ACC
      elsif Instr_WB = MUL then
            RFILE_WB_enable <= "1111";
            RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      ----------------------ACCUMULATOR ACCESS ---------------------------------
      -- MTHI and MTLO doesnt have WB
      elsif Instr_WB = MFLO then
          RFILE_data_sel <= ACC_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rs_wb;
      elsif Instr_WB = MFHI then
          RFILE_data_sel <= ACC_HI;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rs_wb;
      ----------------------LOAD AND STORE -----------------------------------
      elsif Instr_WB = JAL  or ((Instr_WB = BGEZAL or Instr_WB = BLTZAL)
            and LOW = ONE32) or Instr_WB = JALR then
          RFILE_WB_enable <= "1111";
          if Instr_WB = JAL or ((Instr_WB = BGEZAL or Instr_WB = BLTZAL)
             and LOW = ONE32) then
            RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= "11111"; --REG(31)
          elsif Instr_WB = JALR then
            RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
          end if;
          RFILE_data_sel <= CU;
          --we are already in PC+8 since we are in execution cycle so the PC out
          --is 2*4 places ahead!
          Data_to_RFILE  <= PC_jmp_out;
    ----------------------LOAD AND STORE----------------------------------------
     elsif Instr_WB = LBU or Instr_WB = LB or Instr_WB = LH or Instr_WB = LW then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
          case( Instr_WB ) is
              when LBU => RFILE_data_sel <= FROM_MEM8;
              when LB  => RFILE_data_sel <= FROM_MEM8_SGINED;
              when LHU => RFILE_data_sel <= FROM_MEM16;
              when LH  => RFILE_data_sel <= FROM_MEM16_SGINED;
              when others => RFILE_data_sel <= FROM_MEM32; --Instr_WB = LW
          end case;
    elsif Instr_WB = LWL then
          RFILE_WB_enable <= "1100";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
          RFILE_data_sel <= FROM_MEM32;
    elsif Instr_WB = LWR then
          RFILE_WB_enable <= "0011";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
          RFILE_data_sel <= FROM_MEM32;
    --------------------------CO_PROCESSOR 0------------------------------------
    elsif Instr_WB = MFC0 then
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
          RFILE_data_sel <= CU;
          Data_to_RFILE  <= cp0_control(to_integer(unsigned(rd_wb)));
    -------------CONDITION TESTING AND CONDITIONAL MOVE-------------------------
    elsif  Instr_WB = MOVZ and LOW_FF = ONE32 then
        RFILE_WB_enable <= "1111";
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
        RFILE_data_sel <= R2;
    elsif Instr_WB = MOVN and LOW_FF = ZERO32 then
        RFILE_WB_enable <= "1111";
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
        RFILE_data_sel <= R2;
    elsif Instr_WB = SLT or Instr_WB = SLTI or Instr_WB =  SLTU or Instr_WB = SLTIU then
        RFILE_WB_enable <= "1111";
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
        RFILE_data_sel <= CU;
        if LOW_FF = ONE32 then
          Data_to_RFILE  <= "00000000000000000000000000000001";
        else
          Data_to_RFILE  <= (others => '0');
        end if;
    end if;
end process;

--------------------------------------------------------------------------------
--PC handling
--------------------------------------------------------------------------------
PC_HANDLING: process(PC_out,Instr_E, LOW, IMMEDIATE_EX, EPC, PC_jmp_out)begin
        PC_in <= PC_out + 4;
        flush_F2 <= '0';
        PC_jmp_in <= PC_jmp_out;
        if Instr_E = SYSCALL  then
          PC_in <= LOW;			-- supposed to be contents of R2
        elsif Instr_E = ERET then
          PC_in <= EPC;
        elsif Instr_E = J then
          flush_F2 <= '1';
          PC_in <= PC_out(31 downto 28) & InstrReg_out_E(25 downto 0) & "00";
        elsif Instr_E = JR then
          -- we are stroing PC in PC_jmp because we need WB for LINK.
          -- and by that time we have overwritten PC!
          PC_jmp_in <= PC_out;
          flush_F2 <= '1';
          PC_in <= LOW;
        elsif Instr_E = JAL then
          -- we are stroing PC in PC_jmp because we need WB for LINK.
          -- and by that time we have overwritten PC!
          PC_jmp_in <= PC_out;
          flush_F2 <= '1';
          PC_in <= PC_out(31 downto 28) & INST_INDEX_EX & "00";
        elsif Instr_E = BEQ or Instr_E = BGTZ or Instr_E = BGEZ or
              Instr_E = BGEZAL or Instr_E = BLEZ or Instr_E = BLTZ or
              Instr_E = BLTZAL then
            if LOW = ONE32 then
                flush_F2 <= '1';
                -- we are stroing PC in PC_jmp because we need WB in case of
                -- BGEZAL and BLTZAL. and by that time we have overwritten PC!
                PC_jmp_in <= PC_out;
                if IMMEDIATE_EX(15) = '0' then
                  PC_in <= PC_out +(ZERO14 & IMMEDIATE_EX & "00")-1;
                else
                  PC_in <= PC_out +(ONE14 & IMMEDIATE_EX & "00")-1;
                end if;
            end if;
        elsif Instr_E = BNE then
            if LOW = ZERO32 then
                flush_F2 <= '1';
                if IMMEDIATE_EX(15) = '0' then
                  PC_in <= PC_out +(ZERO14 & IMMEDIATE_EX & "00")-1;
                else
                  PC_in <= PC_out +(ONE14 & IMMEDIATE_EX & "00")-1;
                end if;
            end if;
        end if;
end process;

--------------------------------------------------------------------------------
-- Instr decoder
--------------------------------------------------------------------------------
INST_DECODER: process (SPECIAL_F, opcode_F)
begin
    Instr_F <= NOP;
    Illigal_opcode <= '0';
    case SPECIAL_F is
      when "000000" =>
          case(opcode_F) is
              when "000000" => Instr_F <= SLL_inst;
              when "000010" => Instr_F <= SRL_inst;
              when "000011" => Instr_F <= SRA_inst;
              when "000100" => Instr_F <= SLLV;
              when "000110" => Instr_F <= SRLV;
              when "000111" => Instr_F <= SRAV;
              when "001000" => Instr_F <= JR;
              when "001001" => Instr_F <= JALR;
              when "001010" => Instr_F <= MOVZ;
              when "001011" => Instr_F <= MOVN;
              when "001100" => Instr_F <= SYSCALL;
              when "010000" => Instr_F <= MFHI;
              when "010001" => Instr_F <= MTHI;
              when "010010" => Instr_F <= MFLO;
              when "010011" => Instr_F <= MTLO;
              when "011000" => Instr_F <= MULT;
              when "011001" => Instr_F <= MULTU;
              when "011010" => Instr_F <= DIV;
              when "011011" => Instr_F <= DIVU;
              when "100000" => Instr_F <= ADD;
              when "100001" => Instr_F <= ADDU;
              when "100010" => Instr_F <= SUB;
              when "100011" => Instr_F <= SUBU;
              when "100100" => Instr_F <= AND_inst;
              when "100101" => Instr_F <= OR_inst;
              when "100110" => Instr_F <= XOR_inst;
              when "100111" => Instr_F <= NOR_inst;
              when "101010" => Instr_F <= SLT;
              when "101011" => Instr_F <= SLTU;
              when "110000" => Instr_F <= TGE;
              when "110001" => Instr_F <= TGEU;
              when "110100" => Instr_F <= TEQ;
              when others => Illigal_opcode <= '1';
          end case;
      when "000001" =>
          case(BRANCH_FIELD) is
              when "00000" => Instr_F <= BLTZ;
              when "00001" => Instr_F <= BGEZ;
              when "01000" => Instr_F <= TGEI;
              when "01001" => Instr_F <= TGEIU;
              when "01100" => Instr_F <= TEQI;
              when "10000" => Instr_F <= BLTZAL;
              when "10001" => Instr_F <= BGEZAL;
              when others => Illigal_opcode <= '1';
          end case;
      when "000010" => Instr_F <= J;
      when "000011" => Instr_F <= JAL;
      when "000100" => Instr_F <= BEQ;
      when "000101" => Instr_F <= BNE;
      when "000110" => Instr_F <= BLEZ;
      when "000111" => Instr_F <= BGTZ;
      when "001000" => Instr_F <= ADDI;
      when "001001" => Instr_F <= ADDIU;
      when "001010" => Instr_F <= SLTI;
      when "001011" => Instr_F <= SLTIU;
      when "001100" => Instr_F <= ANDI;
      when "001101" => Instr_F <= ORI;
      when "001110" => Instr_F <= XORI;
      when "001111" => Instr_F <= LUI;
      when "010000" =>
            if opcode_F = "011000" then
                Instr_F <= ERET;
            elsif MF = "00000" then
                Instr_F <= MFC0;
            elsif MF = "00100" then
                Instr_F <= MTC0;
            end if;
      when "011100" =>
            case(opcode_F) is
              when "000000" => Instr_F <= MADD;
              when "000001" => Instr_F <= MADDU;
              when "000010" => Instr_F <= MUL;
              when "000100" => Instr_F <= MSUB;
              when "000101" => Instr_F <= MSUBU;
              when "100000" => Instr_F <= CLZ;
              when "100001" => Instr_F <= CLO;
              when others => Illigal_opcode <= '1';
            end case;
      when "100000" => Instr_F <= LB;
      when "100001" => Instr_F <= LH;
      when "100010" => Instr_F <= LWL;
      when "100011" => Instr_F <= LW;
      when "100100" => Instr_F <= LBU;
      when "100101" => Instr_F <= LHU;
      when "100110" => Instr_F <= LWR;
      when "101000" => Instr_F <= SB;
      when "101001" => Instr_F <= SH;
      when "101010" => Instr_F <= SWL;
      when "101011" => Instr_F <= SW;
      when "101110" => Instr_F <= SWR;
      when others =>
            Illigal_opcode <= '1';
    end case;
end process;

end RTL;
