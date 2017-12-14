--Copyright (C) 2017 Siavoosh Payandeh Azad

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
use work.pico_cpu.all;

-- Regarding the jumps, we assume that the compiler always executes 2 instructions
-- after the jump! so we will not have to insert any bubble into the pipeline!


entity ControlUnit is
  generic (BitWidth: integer;
           InstructionWidth: integer);
  port(
    rst             : in  std_logic;
    clk             : in  std_logic;
    ----------------------------------------
    Instr_In        : in  std_logic_vector (InstructionWidth-1 downto 0);
    Instr_Add       : out std_logic_vector (BitWidth+1 downto 0);
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
end ControlUnit;


architecture RTL of ControlUnit is

  ---------------------------------------------
  --      Signals and Types
  ---------------------------------------------

  signal Instr_F, Instr_D, Instr_E, Instr_WB :Instruction := NOP;

  signal SP_in, SP_out : std_logic_vector (BitWidth-1 downto 0):= (others => '0');
  signal PC_in, PC_out : std_logic_vector (BitWidth+1 downto 0):= (others => '0');
  signal InstrReg_out_D, InstrReg_out_E, InstrReg_out_WB: std_logic_vector (InstructionWidth-1 downto 0) := (others => '0');
  signal arithmetic_operation : std_logic;
  signal halt_signal_in, halt_signal : std_logic := '0';
  signal IO_WR_in, IO_WR_in_FF : std_logic_vector(BitWidth-1 downto 0);
  signal IO_DIR_in, IO_DIR_FF :std_logic;
  signal address_error : std_logic;
  ---------------------------------------------
  --      OpCode Aliases
  ---------------------------------------------
  alias LOW  : std_logic_vector is DPU_RESULT(31 downto 0);
  alias HIGH : std_logic_vector is DPU_RESULT(63 downto 32);

  alias LOW_FF  : std_logic_vector is DPU_RESULT_FF(31 downto 0);
  alias HIGH_FF : std_logic_vector is DPU_RESULT_FF(63 downto 32);

  alias SPECIAL_in : std_logic_vector (5 downto 0) is Instr_In (31 downto 26);
  alias opcode_in  : std_logic_vector (5 downto 0) is Instr_In (5 downto 0);

  alias SPECIAL : std_logic_vector (5 downto 0) is InstrReg_out_D (31 downto 26);

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


  alias IMMEDIATE : std_logic_vector (15 downto 0) is InstrReg_out_E (15 downto 0);
  alias OFFSET : std_logic_vector (15 downto 0) is InstrReg_out_E (15 downto 0);
  alias BASE   : std_logic_vector (4 downto 0) is InstrReg_out_D (25 downto 21);
  alias BGEZ_field: std_logic_vector (4 downto 0) is InstrReg_out_D (20 downto 16);

  begin
    flush_pipeline <= '0';
  ---------------------------------------------
  -- Registers setting
  ---------------------------------------------
  process (clk,rst)
    begin
    if rst = '1' then
       PC_out <= (others => '0');
       --InstrReg_out(InstructionWidth-1 downto BitWidth) <= "111110";
       InstrReg_out_D <= (others=> '0');
       InstrReg_out_E <= (others=> '0');
       InstrReg_out_WB <= (others=> '0');
       Instr_D <= NOP;
       Instr_E <= NOP;
       Instr_WB <= NOP;
       halt_signal<= '0';
       IO_WR_in_FF <=  (others=> '0');
       IO_DIR_FF <= '0';
    elsif clk'event and clk='1' then
       IO_WR_in_FF <= IO_WR_in;
       IO_DIR_FF <= IO_DIR_in;
       PC_out <= PC_in;
       halt_signal<= halt_signal_in;
       if halt_signal = '0' then
         InstrReg_out_D <= Instr_In;
         InstrReg_out_E <= InstrReg_out_D;
         InstrReg_out_WB <= InstrReg_out_E;
         Instr_D <= Instr_F;
         Instr_E <= Instr_D;
         Instr_WB <= Instr_E;
       end if;

  end if;
  end process;


  Instr_Add <= PC_out;
---------------------------------------------
--GPIO STUFF
---------------------------------------------
IO_DIR <= IO_DIR_FF;
IO_WR <= IO_WR_in_FF;


-----------------------------------------------------------
--Control FSM
-----------------------------------------------------------
DEC_SIGNALS_GEN: process(Instr_D, rs_ex, rt_ex)
    begin

      RFILE_out_sel_1 <= (others => '0');
      RFILE_out_sel_2 <= (others => '0');
      -----------------------Arithmetic--------------------------
      if Instr_D = ADD or Instr_D = ADDU or Instr_D = SUB or Instr_D = SUBU  then
          RFILE_out_sel_1  <=  rs_d;
		      RFILE_out_sel_2  <=  rt_d;

      elsif Instr_D = ADDI or Instr_D = ADDIU or  Instr_D = CLO or Instr_D = CLZ then
          RFILE_out_sel_1  <=  rs_d;
    	    RFILE_out_sel_2  <=  rs_d;

      -----------------------LOGICAL--------------------------
      elsif Instr_D = AND_inst or Instr_D = OR_inst or Instr_D = NOR_inst or Instr_D = XOR_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;
      elsif Instr_D = ANDI or Instr_D = ORI or Instr_D = XORI then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;

    -----------------------SHIFT AND ROTATE-----------------
    elsif Instr_D = SLL_inst or Instr_D = SRL_inst or Instr_D = SRA_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rt_d;
    elsif Instr_D = SLLV or Instr_D = SRLV or Instr_D = SRAV then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;
    -----------------------JUMP and BRANCH--------------------------
    elsif Instr_D = J or Instr_D = JAL or Instr_D = JALR or Instr_D = JR or
          Instr_D = BEQ or Instr_D = BNE or Instr_D = BGEZ or Instr_D = BGEZAL or
          Instr_D = BLEZ or Instr_D = BGTZ or Instr_D =  BLTZ or Instr_D = BLTZAL then
          if Instr_D = JALR or Instr_D = JR or Instr_D = BGEZ or Instr_D = BGEZAL
             or Instr_D = BLEZ or Instr_D = BGTZ  or Instr_D = BLTZ or Instr_D = BLTZAL then
                RFILE_out_sel_1  <=  rs_d;
                RFILE_out_sel_2  <=  rs_d;
          elsif Instr_D = BEQ  or Instr_D = BNE then
                RFILE_out_sel_1  <=  rt_d;
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
    ----------------------LOAD AND STORE -----------------------------------
  elsif Instr_D = LB or Instr_D = LBU or Instr_D = LH or Instr_D = LHU or
        Instr_D = LW or Instr_D = LWL  or Instr_D = LWR then
        RFILE_out_sel_1  <=  BASE;
        RFILE_out_sel_2  <=  BASE;
    elsif Instr_D = SB or Instr_D = SH  or Instr_D = SW or Instr_D = SWL or Instr_D = SWR then
        RFILE_out_sel_1  <=  BASE;
        RFILE_out_sel_2  <=  rt_d;
      ----------------------conditional move -----------------------------------
    elsif Instr_D = MOVN or Instr_D = MOVZ or Instr_D = SLT or Instr_D = SLTU then
        RFILE_out_sel_1  <=  rt_d;
        RFILE_out_sel_2  <=  rs_d;
    elsif Instr_D = SLTI or Instr_D = SLTIU then
        RFILE_out_sel_1  <=  rs_d;
        RFILE_out_sel_2  <=  rs_d;
    end if;
  end process;


  EX_SIGNALS_GEN:process(Instr_E, IMMEDIATE, DPU_RESULT)
      begin
        address_error <= '0';
        DPU_SetFlag    <= DPU_CLEAR_NO_FLAG;
        MemWrtAddress  <= (others => '0');
        MemRdAddress   <= (others => '0');
        Mem_RW <= "0000";
        DataToDPU_1 <= (others => '0');
        DataToDPU_2 <= (others => '0');
        DPU_ALUCommand <= ALU_PASS_A;
        DPU_Mux_Cont_1 <= RFILE;
        DPU_Mux_Cont_2 <= RFILE;
        -----------------------Arithmetic--------------------------
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
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            DataToDPU_2 <= ZERO16 & IMMEDIATE;

        elsif Instr_E = ADDIU then
            DPU_ALUCommand <= ALU_ADDU;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;

            if IMMEDIATE(15) = '0' then
              DataToDPU_2 <= ZERO16 & IMMEDIATE;
            else
              DataToDPU_2 <= ONE16 & IMMEDIATE;
            end if;


        elsif Instr_E = LUI then
            DPU_ALUCommand <= ALU_PASS_B;
            DPU_Mux_Cont_1 <= CONT;
            DPU_Mux_Cont_2 <= CONT;
            DataToDPU_2 <= IMMEDIATE & ZERO16;

        elsif Instr_E = CLO then
            DPU_ALUCommand <= ALU_CLO;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;

        elsif Instr_E = CLZ  then
            DPU_ALUCommand <= ALU_CLZ;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;
        -----------------------SHIFT AND ROTATE-----------------
        elsif Instr_E = SLL_inst or Instr_E = SRL_inst or Instr_E = SRA_inst then
            DataToDPU_2 <= ZERO16 & "00000000000" & sa_ex;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            if Instr_E = SLL_inst then
                DPU_ALUCommand <= ALU_SLL;
            elsif Instr_E = SRL_inst then
                DPU_ALUCommand <= ALU_SLR;
            elsif Instr_E = SRA_inst then
                DPU_ALUCommand <= ALU_SAR;
            end if;
        elsif Instr_E = SLLV or Instr_E = SRLV or Instr_E = SRAV then
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;
            if Instr_E = SLLV then
                DPU_ALUCommand <= ALU_SLL;
            elsif Instr_E = SRLV then
                DPU_ALUCommand <= ALU_SLR;
            elsif Instr_E = SRAV then
                DPU_ALUCommand <= ALU_SAR;
            end if;
        -----------------------LOGICAL--------------------------
        elsif Instr_E = ANDI or Instr_E = ORI or Instr_E = XORI then

            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            DataToDPU_2 <= ZERO16 & IMMEDIATE;
            if Instr_E = ORI then
              DPU_ALUCommand <= ALU_OR;
            elsif Instr_E = ANDI then
              DPU_ALUCommand <= ALU_AND;
            elsif Instr_E = XORI then
              DPU_ALUCommand <= ALU_XOR;
            end if;

        elsif Instr_E = AND_inst then
            DPU_ALUCommand <= ALU_AND;
        elsif Instr_E = OR_inst then
              DPU_ALUCommand <= ALU_OR;
        elsif Instr_E = NOR_inst then
            DPU_ALUCommand <= ALU_NOR;
        elsif Instr_E = XOR_inst then
            DPU_ALUCommand <= ALU_XOR;

        -----------------------JUMP and BRANCH--------------------------
        elsif Instr_E = JR or Instr_E = JALR then
            DPU_ALUCommand <= ALU_PASS_A;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;

        elsif Instr_E = BEQ or Instr_E = BNE then
            DPU_ALUCommand <= ALU_EQ;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;

        elsif Instr_E = BGTZ or (Instr_E = BGEZ  or Instr_E = BGEZAL)then
          if Instr_E = BGTZ then
            DPU_ALUCommand <= ALU_COMP;
          elsif Instr_E = BGEZ  or Instr_E = BGEZAL then
            DPU_ALUCommand <= ALU_COMP_EQ;
          end if;
          DPU_Mux_Cont_1 <= RFILE;
          DPU_Mux_Cont_2 <= CONT;
          DataToDPU_2 <= (others => '0');

        elsif Instr_E = BLEZ or Instr_E = BLTZ or Instr_E = BLTZAL then
            if Instr_E = BLTZ  or Instr_E = BLTZAL then
              DPU_ALUCommand <= ALU_COMP;
            elsif Instr_E = BLEZ then
              DPU_ALUCommand <= ALU_COMP_EQ;
            end if;
            DPU_Mux_Cont_1 <= CONT;
            DPU_Mux_Cont_2 <= RFILE;
            DataToDPU_1 <= (others => '0');

        elsif Instr_E = MOVN or Instr_E = MOVZ then
            DPU_ALUCommand <= ALU_EQ;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            DataToDPU_2 <= (others => '0');

        elsif Instr_E = SLT then
            DPU_ALUCommand <= ALU_COMP;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;

        elsif Instr_E = SLTI then
            DPU_ALUCommand <= ALU_COMP;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            if IMMEDIATE(15) = '0' then
              DataToDPU_2 <= ZERO16 & IMMEDIATE;
            else
              DataToDPU_2 <= ONE16 & IMMEDIATE;
            end if;

        elsif Instr_E = SLTU then
            DPU_ALUCommand <= ALU_COMPU;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= RFILE;

        elsif Instr_E = SLTIU then
            DPU_ALUCommand <= ALU_COMPU;
            DPU_Mux_Cont_1 <= RFILE;
            DPU_Mux_Cont_2 <= CONT;
            if IMMEDIATE(15) = '0' then
              DataToDPU_2 <= ZERO16 & IMMEDIATE;
            else
              DataToDPU_2 <= ONE16 & IMMEDIATE;
            end if;
        -----------------------MULTIPLICATION AND DIVISION--------------------------
        elsif Instr_D = MULTU or Instr_D = MULT or Instr_D = MUL or Instr_D = DIV or
              Instr_D = DIVU or Instr_D = MADD  or Instr_D = MADDU or Instr_D = MSUB or
              Instr_D = MSUBU then

              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= RFILE;
              if Instr_E = MULTU  then
                    DPU_ALUCommand <= ALU_MULTU;
              elsif Instr_E = MUL  or Instr_E = MULT then
                    DPU_ALUCommand <= ALU_MULT;
              elsif Instr_E = MADD then
                    DPU_ALUCommand <= ALU_MADD;
              elsif Instr_E = MADDU then
                    DPU_ALUCommand <= ALU_MADDU;
              elsif Instr_E = MSUB then
                    DPU_ALUCommand <= ALU_MSUB;
              elsif Instr_E = MSUBU then
                    DPU_ALUCommand <= ALU_MSUBU;
              end if;
            ----------------------ACCUMULATOR ACCESS -----------------------------------
            -- we dont execute anything!
        elsif Instr_E = MTLO then
              DPU_ALUCommand <= ALU_MTLO;
              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= RFILE;
        elsif Instr_E = MTHI then
              DPU_ALUCommand <= ALU_MTHI;
              DataToDPU_2 <= ZERO16 & "0000000000010000";
              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= CONT;
      ----------------------LOAD AND STORE -----------------------------------
        elsif Instr_E = LBU or Instr_E = LHU or Instr_E = LW  or
              Instr_E = LWL or Instr_E = LWR then
              DPU_ALUCommand <= ALU_ADDU;
              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= CONT;
              if OFFSET(15) = '0' then
                DataToDPU_2 <= ZERO16 & OFFSET;
              else
                DataToDPU_2 <= ONE16 & OFFSET;
              end if;
              MemRdAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);

        elsif Instr_E = LB or Instr_E = LH then
              DPU_ALUCommand <= ALU_ADD;
              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= CONT;
              if OFFSET(15) = '0' then
                DataToDPU_2 <= ZERO16 & OFFSET;
              else
                DataToDPU_2 <= ONE16 & OFFSET;
              end if;
              MemRdAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);
        ------------------------store----------------
        elsif Instr_E = SB or Instr_E = SH or Instr_E = SW  or Instr_E = SWL or Instr_E = SWR then
              DPU_ALUCommand <= ALU_ADDU;
              DPU_Mux_Cont_1 <= RFILE;
              DPU_Mux_Cont_2 <= CONT;
              if OFFSET(15) = '0' then
                DataToDPU_2 <= ZERO16 & OFFSET;
              else
                DataToDPU_2 <= ONE16 & OFFSET;
              end if;

              -- Address Error Generration!
              if (Instr_E = SH) and DPU_RESULT(0) /= '0' then
                address_error <= '1';
              elsif (Instr_E = SW) and DPU_RESULT(1 downto 0) /= "00" then
                address_error <= '1';
              end if;

              MemWrtAddress <= DPU_RESULT(CPU_Bitwidth-1 downto 0);
              MEM_IN_SEL <= RFILE_DATA_2;
              if Instr_E = SB then
                Mem_RW <= "0001";
              elsif Instr_E = SH then
                Mem_RW <= "0011";
              elsif Instr_E = SW then
                Mem_RW <= "1111";
              elsif Instr_E = SWL then
                Mem_RW <= "1100";
              elsif Instr_E = SWR then
                Mem_RW <= "0011";
              end if;

        end if;
    end process;


  WB_SIGNALS_GEN:process(Instr_E,Instr_WB, rd_ex, rt_ex, rs_ex, rt_wb, PC_out, LOW)
      begin

      RFILE_in_address   <= (others => '0');
      RFILE_data_sel <= ZERO;
      Data_to_RFILE  <= (others => '0');
      RFILE_WB_enable <= "0000";
      -----------------------Arithmetic--------------------------
      if Instr_E = ADD or Instr_E = ADDU or Instr_E = SUB or Instr_E = SUBU or Instr_E = CLO or Instr_E = CLZ then
          RFILE_data_sel <= DPU_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      elsif Instr_E = ADDI or Instr_E = ADDIU or Instr_E = LUI then
          RFILE_data_sel <= DPU_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_ex;
      -----------------------logical--------------------------
      elsif Instr_E = AND_inst or Instr_E = OR_inst or Instr_E = NOR_inst or Instr_E = XOR_inst then
          RFILE_data_sel <= DPU_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;

      elsif Instr_E = ANDI or Instr_E = ORI or Instr_E = XORI then
          RFILE_data_sel <= DPU_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_ex;
      -----------------------SHIFT AND ROTATE-----------------
      elsif Instr_E = SLL_inst or Instr_E = SRL_inst or Instr_E = SLLV or
            Instr_E = SRLV or Instr_E = SRA_inst or Instr_E = SRAV then
          RFILE_data_sel <= DPU_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      --  MULT and MULTU only WRITES IN ACC
      elsif Instr_E = MUL then
            RFILE_data_sel <= DPU_LOW;
            RFILE_WB_enable <= "1111";
            RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      ----------------------ACCUMULATOR ACCESS -----------------------------------
      elsif Instr_E = MFLO then
          RFILE_data_sel <= ACC_LOW;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rs_ex;
      elsif Instr_E = MFHI then
          RFILE_data_sel <= ACC_HI;
          RFILE_WB_enable <= "1111";
          RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rs_ex;
    end if;

      ----------------------LOAD AND STORE -----------------------------------
    if Instr_E = JAL  or ((Instr_E = BGEZAL or Instr_E = BLTZAL) and LOW = ONE32) or Instr_E = JALR then
      RFILE_WB_enable <= "1111";
      if Instr_E = JAL or ((Instr_E = BGEZAL or Instr_E = BLTZAL) and LOW = ONE32) then
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= "11111"; --REG(31)
      elsif Instr_E = JALR then
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      end if;
      RFILE_data_sel <= CU;
      Data_to_RFILE  <= PC_out+8;
    end if;
    -------------------------------------------------------------------------
    if Instr_WB = LBU or Instr_WB = LB or Instr_WB = LH or Instr_WB = LW then
        RFILE_WB_enable <= "1111";
        RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;

        if Instr_WB = LBU then
            RFILE_data_sel <= FROM_MEM8;
        elsif Instr_WB = LB then
            RFILE_data_sel <= FROM_MEM8_SGINED;
        elsif Instr_WB = LH then
            RFILE_data_sel <= FROM_MEM16_SGINED;
        elsif Instr_WB = LHU then
            RFILE_data_sel <= FROM_MEM16;
        elsif Instr_WB = LW then
            RFILE_data_sel <= FROM_MEM32;
        end if;
    end if;
    -----------------------JUMP and BRANCH--------------------------
    if Instr_WB = LWL then
      RFILE_WB_enable <= "1100";
      RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      RFILE_data_sel <= FROM_MEM32;
    end if;

    if Instr_WB = LWR then
      RFILE_WB_enable <= "0011";
      RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      RFILE_data_sel <= FROM_MEM32;
    end if;

    if  Instr_E = MOVZ and LOW = ONE32 then
      RFILE_WB_enable <= "1111";
      RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      RFILE_data_sel <= R2;
    end if;

    if  Instr_E = MOVN and LOW = ZERO32 then
      RFILE_WB_enable <= "1111";
      RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      RFILE_data_sel <= R2;
    end if;

    if Instr_E = SLT or Instr_E = SLTI or Instr_E =  SLTU or Instr_E = SLTIU then
      RFILE_WB_enable <= "1111";
      RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0)  <= rd_ex;
      RFILE_data_sel <= CU;
      if low = ONE32 then
        Data_to_RFILE  <= "00000000000000000000000000000001";
      else
        Data_to_RFILE  <= (others => '0');
      end if;
    end if;
    end process;

--PC handling------------------------------------------------------------------------
PC_HANDLING:
process(PC_out,Instr_E, halt_signal, LOW, IMMEDIATE )begin

    halt_signal_in <= halt_signal;

    if halt_signal = '1' then
        pc_in <= PC_out;
    else
        PC_in <= PC_out + 4;
        if Instr_E = J then
          PC_in <= PC_out(33 downto 28) & InstrReg_out_E(25 downto 0) & "00";
        elsif Instr_E = JR then
          PC_in <= LOW;
        elsif Instr_E = JAL then
          PC_in <= LOW;
        elsif Instr_E = BEQ or Instr_E = BGTZ or Instr_E = BGEZ or
              Instr_E = BGEZAL or Instr_E = BLEZ or Instr_E = BLTZ or
              Instr_E = BLTZAL then
            if LOW = ONE32 then
                if IMMEDIATE(15) = '0' then
                  PC_in <= PC_out +(ZERO14 & IMMEDIATE & "00")-1;
                else
                  PC_in <= PC_out +(ONE14 & IMMEDIATE & "00")-1;
                end if;
            end if;
        elsif Instr_E = BNE then
            if LOW = ZERO32 then
                if IMMEDIATE(15) = '0' then
                  PC_in <= PC_out +(ZERO14 & IMMEDIATE & "00")-1;
                else
                  PC_in <= PC_out +(ONE14 & IMMEDIATE & "00")-1;
                end if;
            end if;
        end if;
    end if;
end process;

------------------------------------------------
-- Instr decoder
------------------------------------------------
INST_DECODER:
process (SPECIAL_in, opcode_in)
begin
    Instr_F <= NOP;
        case SPECIAL_in is
          when "000000" =>
              if opcode_in = "000000" then
                  Instr_F <= SLL_inst;
              elsif opcode_in = "000010" then
                  Instr_F <= SRL_inst;
              elsif opcode_in = "000011" then
                  Instr_F <= SRA_inst;
              elsif opcode_in = "000100" then
                  Instr_F <= SLLV;
              elsif opcode_in = "000110" then
                  Instr_F <= SRLV;
              elsif opcode_in = "000111" then
                  Instr_F <= SRAV;
              elsif opcode_in = "001000" then
                  Instr_F <= JR;
              elsif opcode_in = "001001" then
                  Instr_F <= JALR;
              elsif opcode_in = "001010" then
                  Instr_F <= MOVZ;
              elsif opcode_in = "001011" then
                  Instr_F <= MOVN;
              elsif opcode_in = "010000" then
                  Instr_F <= MFHI;
              elsif opcode_in = "010001" then
                  Instr_F <= MTHI;
              elsif opcode_in = "010010" then
                  Instr_F <= MFLO;
              elsif opcode_in = "010011" then
                  Instr_F <= MTLO;
              elsif opcode_in = "011000" then
                  Instr_F <= MULT;
              elsif opcode_in = "011001" then
                  Instr_F <= MULTU;
              elsif opcode_in = "100000" then
                  Instr_F <= ADD;
              elsif opcode_in = "100001" then
                  Instr_F <= ADDU;
              elsif opcode_in = "100010" then
                  Instr_F <= SUB;
              elsif opcode_in = "100011" then
                  Instr_F <= SUBU;
              elsif opcode_in = "100100" then
                  Instr_F <= AND_inst;
              elsif opcode_in = "100101" then
                  Instr_F <= OR_inst;
              elsif opcode_in = "100110" then
                  Instr_F <= XOR_inst;
              elsif opcode_in = "100111" then
                  Instr_F <= NOR_inst;
              elsif opcode_in = "101010" then
                  Instr_F <= SLT;
              elsif opcode_in = "101011" then
                  Instr_F <= SLTU;
              end if;
          when "000001" =>
              if BGEZ_field = "00000" then
                Instr_F <= BLTZ;
              elsif BGEZ_field = "10000" then
                Instr_F <= BLTZAL;
              elsif BGEZ_field = "00001" then
                Instr_F <= BGEZ;
              elsif BGEZ_field = "10001" then
                Instr_F <= BGEZAL;
              end if;
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
          when "011100" =>
                if opcode_in = "000000" then
                    Instr_F <= MADD;
                elsif  opcode_in = "000001" then
                    Instr_F <= MADDU;
                elsif opcode_in = "000010" then
                    Instr_F <= MUL;
                elsif opcode_in = "000100" then
                    Instr_F <= MSUB;
                elsif opcode_in = "000101" then
                    Instr_F <= MSUBU;
                elsif opcode_in = "100001" then
                    Instr_F <= CLO;
                elsif opcode_in = "100000" then
                    Instr_F <= CLZ;
                end if;
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
          when others =>  Instr_F <= NOP;
        end case;
end process;

end RTL;
