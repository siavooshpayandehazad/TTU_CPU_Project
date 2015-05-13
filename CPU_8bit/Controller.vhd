
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL; 


entity ControlUnit is
  generic (BitWidth: integer;
           InstructionWidth: integer);
  port(
    ----------------------------------------    
    rst: in std_logic;
    clk: in std_logic;     
    ----------------------------------------    
    Instr_In: in std_logic_vector (InstructionWidth-1 downto 0);
    Instr_Add: out std_logic_vector (BitWidth-1 downto 0);    
    ----------------------------------------    
    MemRdAddress: out std_logic_vector (BitWidth-1 downto 0);
	 MemWrtAddress: out std_logic_vector (BitWidth-1 downto 0);
    Mem_RW: out std_logic;
    ----------------------------------------     
    DPU_Flags: in std_logic_vector (3 downto 0);
    DataToDPU: out std_logic_vector (BitWidth-1 downto 0);
    CommandToDPU: out std_logic_vector (10 downto 0);
	 Reg_in_sel: out std_logic_vector (7 downto 0);
	 Reg_out_sel: out std_logic_vector (2 downto 0); 
    DataFromDPU: in std_logic_vector (BitWidth-1 downto 0)
    
    ----------------------------------------
  );
end ControlUnit;


architecture RTL of ControlUnit is
  
  ---------------------------------------------
  --      Signals and Types
  ---------------------------------------------

  TYPE STATE_TYPE IS (Fetch, Decode, Execution,WriteBack);
  signal State_in, State_out :STATE_TYPE;
  
  TYPE Instruction IS (PUSH,POP,
                       JMPEQ,Jmp_rel,Jmp,JmpZ,JmpOV,JmpC,
                       FlipA,And_A_R,OR_A_R,XOR_A_R,NegA,
                       ShiftA_R,ShiftA_L,ShiftArithL,ShiftArithR,
                       RRC,RLC,
                       LoadPC,SavePC,
                       Add_A_R, Add_A_Mem,Add_A_Dir, Sub_A_R,Sub_A_Mem,Sub_A_Dir,IncA,DecA,
                       Load_A_Mem,Load_R0_Mem,Load_R0_Dir,Store_A_Mem,load_A_R,load_R_A,Load_Ind_A,
                       ClearZ,ClearOV,ClearC, ClearACC,
                       NOP,HALT);
  signal Instr:Instruction;  
    
  signal SP_in, SP_out : std_logic_vector (BitWidth-1 downto 0):= (others => '0');
  signal PC_in, PC_out : std_logic_vector (BitWidth-1 downto 0):= (others => '0');
  signal InstrReg_out: std_logic_vector (InstructionWidth-1 downto 0);
  
  ---------------------------------------------
  --      OpCode Aliases
  ---------------------------------------------
  alias opcpde : std_logic_vector (5 downto 0) is InstrReg_out (InstructionWidth-1 downto BitWidth); 
  
  begin
  
  ---------------------------------------------
  -- Registers setting  
  ---------------------------------------------
  process (clk,rst)
    begin
    if rst = '1' then 
        
       State_out <= Fetch; 
       SP_out <= (others => '0');         
       PC_out <= (others => '0');
       InstrReg_out <= (others => '0');
       
    elsif clk'event and clk='1' then
       State_out <= State_in;
       SP_out <= SP_in;
       PC_out <= PC_in;
       InstrReg_out <= Instr_In;
       
  end if; 
  end process;
  ---------------------------------------------
  
   
-----------------------------------------------------------
--Control FSM
-----------------------------------------------------------   
   
  process(State_out,PC_out,Instr,InstrReg_out,DataFromDPU,SP_out,DPU_Flags) 
    begin
    SP_in <= SP_out;
	 PC_in <= PC_out;
	 Instr_Add <= PC_out;
    Mem_RW <= '0';
	 
    case State_out IS
--Fetch--------------------------------------------------------------------------  
            WHEN Fetch => 
				    
                DataToDPU <= (others => '0');
                MemRdAddress <= (others => '0');
					 MemWrtAddress <= (others => '0');
                CommandToDPU <= "00000001000"; --do not do anything
					 Reg_in_sel<="00000000";
					 Reg_out_sel<="000";
                Mem_RW <= '0';
                State_in <= Decode;
--Decode-------------------------------------------------------------------------                
            WHEN Decode =>  
                DataToDPU <= (others => '0');
                MemRdAddress <= (others => '0');
					 MemWrtAddress <= (others => '0');
                CommandToDPU <= "00000001000"; --do not do anything
					 Reg_in_sel<="00000000";
					 Reg_out_sel<="000";
                State_in <= Execution;
--Execution------------------------------------------------------------------------
            WHEN Execution => 
               DataToDPU <= (others => '0');
              MemRdAddress <= (others => '0');
				  MemWrtAddress <= (others => '0');
              Mem_RW <= '0';
              CommandToDPU <= "00000001000"; --do not do anything
				  Reg_in_sel<="00000000";
				  Reg_out_sel<="000";
              State_in <= WriteBack;
                -----------------------------------------------------------
                -----------------------Arithmetic--------------------------
                -----------------------------------------------------------
                if Instr = Add_A_R then 
                  CommandToDPU <= "00000000010"; 
						Reg_out_sel<= InstrReg_out (2 downto 0);
						
                elsif Instr = Add_A_Mem then 
                  MemRdAddress <= InstrReg_out (BitWidth-1 downto 0);
                  CommandToDPU <= "00000000000";
                
                elsif Instr = Add_A_Dir then 
                   DataToDPU <= InstrReg_out (BitWidth-1 downto 0);
                  CommandToDPU <= "00000000001";
                
                -----------------------------------------------
                elsif Instr = Sub_A_R then 
                  CommandToDPU <= "00000000110";
						Reg_out_sel<= InstrReg_out (2 downto 0);
						
                elsif Instr = Sub_A_Mem then 
                  MemRdAddress <= InstrReg_out (BitWidth-1 downto 0);
                  CommandToDPU <= "00000000100";
                  
                elsif Instr = Sub_A_Dir then 
                  DataToDPU <= InstrReg_out (BitWidth-1 downto 0);
                  CommandToDPU <= "00000000101";
                -----------------------------------------------                  
                elsif Instr = IncA then 
                  CommandToDPU <= "00000000011";
 
                elsif Instr = DecA then 
                  CommandToDPU <= "00000000111";
                
  
                -----------------------------------------------------------
                -----------------------Shift-------------------------------
                -----------------------------------------------------------
                elsif Instr = ShiftA_R  then
                  CommandToDPU <= "00000011100";
   
                elsif Instr = ShiftA_L  then
                  CommandToDPU <= "00000100000";
                
                elsif Instr = ShiftArithL  then
                  CommandToDPU <= "00000101100";
                
                elsif Instr = ShiftArithR  then
                  CommandToDPU <= "00000101000";
                  
                elsif Instr = RRC  then
                  CommandToDPU <= "00000111000";  
                
                elsif Instr = RLC  then
                  CommandToDPU <= "00000111100";  
                  
                -----------------------------------------------------------
                -----------------------Logical-----------------------------
                -----------------------------------------------------------
                 elsif Instr = NegA then 
                  CommandToDPU <= "00000100100";
                  
                 elsif Instr = FlipA then 
                  CommandToDPU <= "00000110000";
						
                elsif Instr = And_A_R  then
                  CommandToDPU <= "00000010010";
						Reg_out_sel<= InstrReg_out (2 downto 0);
          
                elsif Instr = OR_A_R  then
                  CommandToDPU <= "00000010110";
						Reg_out_sel<= InstrReg_out (2 downto 0);
						
                elsif Instr = XOR_A_R  then
                  CommandToDPU <= "00000011010";
						Reg_out_sel<= InstrReg_out (2 downto 0);
                -----------------------------------------------------------
                -----------------------Memory------------------------------
                -----------------------------------------------------------
                elsif Instr = Load_R0_Mem  then
                  
                  MemRdAddress <= InstrReg_out (BitWidth-1 downto 0);
                  Mem_RW <= '0';
                  CommandToDPU <= "11000001000";
                  Reg_in_sel<= "00000001";
						
                elsif Instr = Load_A_Mem  then
                  MemRdAddress <= InstrReg_out (BitWidth-1 downto 0);
                  Mem_RW <= '0';
                  CommandToDPU <= "00000001100";
						  
                elsif Instr = SavePC  then
                  DataToDPU <= PC_out;
                  CommandToDPU <= "00000001101";
						  
                elsif Instr = Load_R0_Dir  then
                    CommandToDPU <= "01000001000";
                    DataToDPU <= InstrReg_out (BitWidth-1 downto 0);
                    Reg_in_sel<= "00000001";
						  Reg_out_sel<= "000";
						
                elsif Instr = Load_Ind_A  then   
                    MemRdAddress <= DataFromDPU;
                    Mem_RW <= '0';
                    CommandToDPU <= "00000001100";
                    Reg_in_sel<= "00000000";
						  Reg_out_sel<= "000";
                
                elsif Instr = load_A_R then 
                    CommandToDPU <= "00000001100";
						  Reg_out_sel<= InstrReg_out (2 downto 0);
						  
                elsif Instr = load_R_A then 
                    CommandToDPU <= "10000001000";    
                    Reg_in_sel<= InstrReg_out (7 downto 0);
 
                -----------------------------------------------------------
                -----------------------Stack-------------------------------
                -----------------------------------------------------------
                elsif Instr = POP  then
                    MemRdAddress <=   SP_out - "00000001";
                    SP_in <= SP_out - 1;
                    Mem_RW <= '0';
                    CommandToDPU <= "00000001100";
                -----------------------------------------------------------
                -----------------------ClearFlags--------------------------
                -----------------------------------------------------------
                elsif Instr = ClearZ  then
                    CommandToDPU <= "00001001000";
                elsif Instr = ClearOV  then
                   CommandToDPU <= "00010001000"; 
                elsif Instr = ClearC  then    
                   CommandToDPU <= "00100001000";
                elsif Instr = ClearACC  then    
                   CommandToDPU <= "00000110100";   
                  
                else
                CommandToDPU <= "00000001000"; --do not do anything
                end if;
 
--WriteBack------------------------------------------------------------------------
            WHEN WriteBack => 
                DataToDPU <= (others => '0');
                MemRdAddress <= (others => '0');
					 MemWrtAddress <= (others => '0');
                CommandToDPU <= "00000001000"; --do not do anything
					 Reg_in_sel<="00000000";
					 Reg_out_sel<="000";
                State_in <= Fetch;

                if Instr = Store_A_Mem then 
                      MemWrtAddress <= InstrReg_out (BitWidth-1 downto 0);
                      Mem_RW <= '1';
                      PC_in <= PC_out+1;
                elsif Instr = HALT then 
                      PC_in <= PC_out;
                      State_in <= WriteBack;
                      
                -----------------------------------------------------------
                -----------------------Jump--------------------------------
                -----------------------------------------------------------      
                elsif Instr = Jmp then
                      PC_in <= InstrReg_out (BitWidth-1 downto 0);
                      
                elsif Instr = JmpOV and DPU_Flags(0) = '1' then    
                      PC_in <= InstrReg_out (BitWidth-1 downto 0);   
                
                elsif Instr = JmpZ and DPU_Flags(1) = '1' then   
                      PC_in <= InstrReg_out (BitWidth-1 downto 0);
                      
                elsif Instr = JMPEQ and DPU_Flags(2) = '1' then   
                      PC_in <= InstrReg_out (BitWidth-1 downto 0);   
                
                elsif Instr = JmpC and DPU_Flags(3) = '1' then    
                      PC_in <= InstrReg_out (BitWidth-1 downto 0);   
                      
                elsif Instr= Jmp_rel then 
                      PC_in <= PC_out + InstrReg_out (BitWidth-1 downto 0);
                
                elsif Instr= LoadPC then
                      PC_in <= DataFromDPU ;
                      State_in <= Fetch;   
                -----------------------------------------------------------
                -----------------------Stack OP----------------------------
                -----------------------------------------------------------
                          
                elsif Instr= PUSH then
                      PC_in <= PC_out+1;
                      MemWrtAddress <=  SP_out;
                      SP_in <= SP_out + 1;
                      Mem_RW <= '1'; 
                else
                      PC_in <= PC_out+1;
                                             
                end if;    
                
       END case;
  end process;
  
  
  
  
  ------------------------------------------------
  -- Instr decoder
  ------------------------------------------------
  process (opcpde) 
  begin
    case opcpde is
      when "000000" => Instr <= Add_A_R;
      when "000001" => Instr <= Add_A_Mem;
      when "000010" => Instr <= Add_A_Dir;
         
      when "000011" => Instr <= Sub_A_R;   
      when "000100" => Instr <= Sub_A_Mem;  
      when "000101" => Instr <= Sub_A_Dir; 
        
      when "000110" => Instr <= IncA; 
      when "000111" => Instr <= DecA; 
      
        
      when "001000" => Instr <= ShiftArithR;
      when "001001" => Instr <= ShiftArithL;      
      when "001010" => Instr <= ShiftA_R; 
      when "001011" => Instr <= ShiftA_L; 
      when "001100" => Instr <= RRC;        
      when "001101" => Instr <= RLC; 
        
      when "001110" => Instr <= And_A_R; 
      when "001111" => Instr <= OR_A_R;
      when "010000" => Instr <= XOR_A_R;
      when "010001" => Instr <= FlipA;
      when "010010" => Instr <= NegA; 

      when "010011" => Instr <= Jmp;  
      when "010100" => Instr <= JmpZ;
      when "010101" => Instr <= JmpOV;
      when "010110" => Instr <= JmpC;  
      when "010111" => Instr <= Jmp_rel;
      when "011000" => Instr <= JMPEQ;
        
      when "011001" => Instr <= ClearZ;
      when "011010" => Instr <= ClearOV;
      when "011011" => Instr <= ClearC; 
      when "011100" => Instr <= ClearACC;   
        
      when "011101" => Instr <= LoadPC;
      when "011110" => Instr <= SavePC;              
      when "011111" => Instr <= Load_A_Mem;
      when "100000" => Instr <= Store_A_Mem;  
      when "100001" => Instr <= Load_R0_Dir;  
      when "100010" => Instr <= Load_R0_Mem;  
     
      when  "100011" => Instr <= load_A_R;
      when  "100100" => Instr <= load_R_A;
      when  "100101" => Instr <= Load_Ind_A ;
        
      when "111100" => Instr <= PUSH;
      when "111101" => Instr <= POP;
      
      when "111110" => Instr <= NOP;
      when "111111" => Instr <= HALT; 

      when others =>  Instr <= NOP;
      end case;     
        end process;
end RTL;
