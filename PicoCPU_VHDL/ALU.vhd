



library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL; 
 USE IEEE.NUMERIC_STD.ALL;

--ALU entity
entity ALU is
  generic (BitWidth: integer);
  port ( A: in std_logic_vector (BitWidth-1 downto 0);
        B: in std_logic_vector (BitWidth-1 downto 0);
        Command: in std_logic_vector (3 downto 0);
        Cflag_in: in std_logic;
        Cflag_out: out std_logic;
        Result: out std_logic_vector (BitWidth-1 downto 0) 
    );
end ALU;

--Architecture of the DPU
architecture RTL of ALU is
---------------------------------------------
--      component declaration
---------------------------------------------
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
---------------------------------------------
--      Signals
---------------------------------------------
 signal AddSub_result: std_logic_vector (BitWidth-1 downto 0);
 signal Cout,Add_Sub: std_logic;

begin
---------------------------------------------
--      component instantiation
--------------------------------------------- 
Adder_comp: Adder_Sub generic map (BitWidth => BitWidth)  port map (A,B,Add_Sub,AddSub_result,Cout);
---------------------------------------------
Cflag_out <= Cout;


  
PROC_ALU: process(Command,A,B,AddSub_result,Cflag_in)
   begin    
    Add_Sub <= '0';  --adding by default
     case Command is
            WHEN "0000" =>   Result<= AddSub_result; --add
            WHEN "0001" =>   Add_Sub <= '1';
                             Result<= AddSub_result; -- Subtract            
            WHEN "0010" =>   Result<= A;  --Bypass A
            WHEN "0011" =>   Result<= B;  --Bypass B
            WHEN "0100" =>   Result<= A and B;  --And
            WHEN "0101" =>   Result<= A or B;  --or     
            WHEN "0110" =>   Result<= A xor B;  --xor   
            WHEN "0111" =>   Result<= '0' & A(BitWidth-1 downto 1) ;  --shift right      
            WHEN "1000" =>   Result<= A(BitWidth-2 downto 0)& '0' ;  --shift left    
            WHEN "1001" =>   Result<= not A +1;  --negation
            WHEN "1010" =>   Result<= A(BitWidth-1) & A(BitWidth-1 downto 1) ;  --shift right Arith
            WHEN "1011" =>   Result<= A(BitWidth-1) & A(BitWidth-3 downto 0)& A(0) ;  --shift left Arith
            WHEN "1100" =>   Result<= not(A); --Not of A
            WHEN "1101" =>   Result<= (others => '0'); --Clear ACC
            WHEN "1110" =>   Result<= Cflag_in & A(BitWidth-1 downto 1); -- RRC
            WHEN "1111" =>   Result<= A(BitWidth-2 downto 0)& Cflag_in ; -- RLC
       WHEN OTHERS => Result<= (others => '0');
    END CASE;
     
 end process PROC_ALU;
  
end RTL;
