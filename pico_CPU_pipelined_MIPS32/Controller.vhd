
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
use work.pico_cpu.all;

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
  signal flush_signal_D, flush_signal_E: std_logic;
  signal IO_WR_in, IO_WR_in_FF : std_logic_vector(BitWidth-1 downto 0);
  signal IO_DIR_in, IO_DIR_FF :std_logic;
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

  begin
    flush_pipeline <= flush_signal_D;
  ---------------------------------------------
  -- Registers setting
  ---------------------------------------------
  process (clk,rst)
    begin
    if rst = '1' then
       SP_out <= (others => '0');
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
       SP_out <= SP_in;
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
DEC_SIGNALS_GEN:
  process(Instr_D, rs_ex, rt_ex)
    begin
      flush_signal_D <= '0';
      RFILE_out_sel_1 <= (others => '0');
      RFILE_out_sel_2 <= (others => '0');
      -----------------------Arithmetic--------------------------
      if Instr_D = ADDU then
          RFILE_out_sel_1  <=  rt_d;
		      RFILE_out_sel_2  <=  rs_d;

      elsif Instr_D = ADDI then
          RFILE_out_sel_1  <=  rs_d;
    	    RFILE_out_sel_2  <=  rs_d;

      elsif Instr_D = ADDIU then
          RFILE_out_sel_1  <=  rs_d;
      	  RFILE_out_sel_2  <=  rs_d;

      elsif Instr_D = SUBU then
          RFILE_out_sel_1  <=  rt_d;
      		RFILE_out_sel_2  <=  rs_d;

     elsif Instr_D = CLO or Instr_D = CLZ  then
           RFILE_out_sel_1  <=  rs_d;
           RFILE_out_sel_2  <=  rs_d;
      -----------------------LOGICAL--------------------------
      elsif Instr_D = AND_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;

      elsif Instr_D = ANDI then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;

     elsif Instr_D = OR_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;

     elsif Instr_D = ORI then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;

     elsif Instr_D = NOR_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;

    elsif Instr_D = XOR_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;

    elsif Instr_D = XORI then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;

    -----------------------SHIFT AND ROTATE-----------------
    elsif Instr_E = SLL_inst then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rt_d;
    -----------------------JUMP and BRANCH--------------------------
    elsif Instr_D = J  then
          flush_signal_D <= '1';
    elsif Instr_D = JR  then
          RFILE_out_sel_1  <=  rs_d;
          RFILE_out_sel_2  <=  rs_d;
          flush_signal_D <= '1';
    elsif Instr_D = BEQ  then
          RFILE_out_sel_1  <=  rt_d;
          RFILE_out_sel_2  <=  rs_d;
          flush_signal_D <= '1';

    -----------------------MULTIPLICATION AND DIVISION--------------------------
   elsif Instr_D = MULTU or Instr_D = MULT then
         RFILE_out_sel_1  <=  rt_d;
         RFILE_out_sel_2  <=  rs_d;
    elsif Instr_D = MUL then
         RFILE_out_sel_1  <=  rt_d;
         RFILE_out_sel_2  <=  rs_d;
    end if;
  end process;


  EX_SIGNALS_GEN:
    process(Instr_E, IMMEDIATE)
      begin
        flush_signal_E <= '0';
        DPU_SetFlag    <= DPU_CLEAR_NO_FLAG;

        DataToDPU <= (others => '0');
        DPU_ALUCommand <= ALU_PASS_A;
        DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
        DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
        -----------------------Arithmetic--------------------------
        if Instr_E = ADDU then
            DPU_ALUCommand <= ALU_ADD;

        elsif Instr_E = ADDI then

            DPU_ALUCommand <= ALU_ADD;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
            DataToDPU <= ZERO16 & IMMEDIATE;

        elsif Instr_E = ADDIU then
            DPU_ALUCommand <= ALU_ADD;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;

            if IMMEDIATE(15) = '0' then
              DataToDPU <= ZERO16 & IMMEDIATE;
            else
              DataToDPU <= ONE16 & IMMEDIATE;
            end if;

        elsif Instr_E = SUBU then
            DPU_ALUCommand <= ALU_SUB;

        elsif Instr_E = LUI then
            DPU_ALUCommand <= ALU_PASS_B;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_CONT;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
            DataToDPU <= IMMEDIATE & ZERO16;

        elsif Instr_E = CLO then
            DPU_ALUCommand <= ALU_CLO;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;

        elsif Instr_E = CLZ  then
            DPU_ALUCommand <= ALU_CLZ;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
        -----------------------SHIFT AND ROTATE-----------------
        elsif Instr_E = SLL_inst then
            DPU_ALUCommand <= ALU_SLL;
            DataToDPU <= ZERO16 & "00000000000" & sa_ex;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
        -----------------------LOGICAL--------------------------
        elsif Instr_E = AND_inst then
            DPU_ALUCommand <= ALU_AND;

        elsif Instr_E = ANDI then
            DPU_ALUCommand <= ALU_AND;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
            DataToDPU <= ZERO16 & IMMEDIATE;

        elsif Instr_E = OR_inst then
              DPU_ALUCommand <= ALU_OR;

        elsif Instr_E = ORI then
            DPU_ALUCommand <= ALU_OR;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
            DataToDPU <= ZERO16 & IMMEDIATE;

        elsif Instr_E = NOR_inst then
            DPU_ALUCommand <= ALU_NOR;

        elsif Instr_E = XOR_inst then
            DPU_ALUCommand <= ALU_XOR;

        elsif Instr_E = XORI then
            DPU_ALUCommand <= ALU_XOR;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_CONT;
            DataToDPU <= ZERO16 & IMMEDIATE;
        -----------------------JUMP and BRANCH--------------------------
        elsif Instr_E = J  then
            flush_signal_E <= '1';

        elsif Instr_E = JR then
            DPU_ALUCommand <= ALU_PASS_A;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
            flush_signal_E <= '1';

        elsif Instr_E = BEQ  then
            DPU_ALUCommand <= ALU_COMP;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
            if LOW = ONE32 then
              flush_signal_E <= '1';
            end if;
        -----------------------MULTIPLICATION AND DIVISION--------------------------
      elsif Instr_E = MULTU  then
            DPU_ALUCommand <= ALU_MULTU;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
      elsif Instr_E = MUL  or Instr_E = MULT then
            DPU_ALUCommand <= ALU_MULT;
            DPU_Mux_Cont_1 <= DPU_DATA_IN_RFILE;
            DPU_Mux_Cont_2 <= DPU_DATA_IN_RFILE;
        end if;
    end process;


  WB_SIGNALS_GEN:
    process(Instr_WB, rt_wb, rd_wb)
      begin

      RFILE_in_sel<= (others => '0');
      RFILE_data_sel<= (others => '0');
      -----------------------Arithmetic--------------------------
      if Instr_WB = ADDU or Instr_WB = SUBU or Instr_WB = CLO or Instr_WB = CLZ then
          RFILE_data_sel <= RFILE_IN_ACC_LOW;
          RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
          RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      elsif Instr_WB = ADDI or Instr_WB = ADDIU or Instr_WB = LUI then
          RFILE_data_sel <= RFILE_IN_ACC_LOW;
          RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
          RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      -----------------------logical--------------------------
      elsif Instr_WB = AND_inst or Instr_WB = OR_inst or Instr_WB = NOR_inst or Instr_WB = XOR_inst then
          RFILE_data_sel <= RFILE_IN_ACC_LOW;
          RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
          RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      elsif Instr_WB = ANDI or Instr_WB = ORI or Instr_WB = XORI then
          RFILE_data_sel <= RFILE_IN_ACC_LOW;
          RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
          RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rt_wb;
      -----------------------SHIFT AND ROTATE-----------------
      elsif Instr_WB = SLL_inst then
        RFILE_data_sel <= RFILE_IN_ACC_LOW;
        RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
        RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      --  MULT and MULTU only WRITES IN ACC
      elsif Instr_WB = MUL then
            RFILE_data_sel <= RFILE_IN_ACC_LOW;
            RFILE_in_sel(RFILE_SEL_WIDTH)<= '1';
            RFILE_in_sel(RFILE_SEL_WIDTH-1 downto 0)  <= rd_wb;
      end if;
    end process;

--PC handling------------------------------------------------------------------------
PC_HANDLING:
process(PC_out,Instr_E, halt_signal, LOW, IMMEDIATE )begin

    halt_signal_in <= halt_signal;

    if halt_signal = '1' then
        pc_in <= PC_out;
    else
        PC_in <= PC_out+4;
        if Instr_E = J then
          PC_in <= PC_out(33 downto 28) & InstrReg_out_E(25 downto 0) & "00";
        elsif Instr_E = JR then
          PC_in <= LOW;
        elsif Instr_E = BEQ then
          if LOW = ONE32 then
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
process (SPECIAL_in, flush_signal_D, flush_signal_E, opcode_in)
begin
    Instr_F <= NOP;
    if flush_signal_D = '0' and flush_signal_E = '0' then
        case SPECIAL_in is
          when "000000" =>
              if opcode_in = "000000" then
                  Instr_F <= SLL_inst;
              elsif opcode_in = "100000" then
                  Instr_F <= ADDU;
              elsif opcode_in = "100011" then
                  Instr_F <= SUBU;
              elsif opcode_in = "011000" then
                  Instr_F <= MULT;
              elsif opcode_in = "011001" then
                  Instr_F <= MULTU;
              elsif opcode_in = "100100" then
                  Instr_F <= AND_inst;
              elsif opcode_in = "100101" then
                  Instr_F <= OR_inst;
              elsif opcode_in = "100110" then
                  Instr_F <= XOR_inst;
              elsif opcode_in = "100111" then
                  Instr_F <= NOR_inst;
              elsif opcode_in = "001000" then
                  Instr_F <= JR;
              end if;
          when "001000" => Instr_F <= ADDI;
          when "001001" => Instr_F <= ADDIU;
          when "001100" => Instr_F <= ANDI;
          when "001101" => Instr_F <= ORI;
          when "001110" => Instr_F <= XORI;
          when "001111" => Instr_F <= LUI;
          when "000010" => Instr_F <= J;
          when "000100" => Instr_F <= BEQ;
          when "011100" =>
                if opcode_in = "000010" then
                    Instr_F <= MUL;
                elsif opcode_in = "100001" then
                    Instr_F <= CLO;
                elsif opcode_in = "100000" then
                    Instr_F <= CLZ;
                end if;
          when others =>  Instr_F <= NOP;
        end case;
    else
      Instr_F <= NOP;
    end if;
end process;

end RTL;
