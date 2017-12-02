library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
use work.pico_cpu.all;

--ALU entity
entity ALU is
  generic (BitWidth: integer);
  port ( A: in std_logic_vector (BitWidth-1 downto 0);
         B: in std_logic_vector (BitWidth-1 downto 0);
         Command: in std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
         Cflag_in: in std_logic;
         Cflag_out: out std_logic;
         Result: out std_logic_vector (BitWidth-1 downto 0)
    );
end ALU;

--Architecture of the DPU
architecture RTL of ALU is
---------------------------------------------
--      Signals
---------------------------------------------
 signal AddSub_result: std_logic_vector (BitWidth-1 downto 0) := (others => '0');
 signal Cout,Add_Sub: std_logic := '0';

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
            WHEN ALU_ADD    =>   Result<= AddSub_result; --add
            WHEN ALU_SUB    =>   Add_Sub <= '1';
                                 Result<= AddSub_result; -- Subtract
            WHEN ALU_PASS_A =>   Result <= A;  --Bypass A
            WHEN ALU_PASS_B =>   Result <= B;  --Bypass B
            WHEN ALU_AND    =>   Result<= A and B;  --And
            WHEN ALU_OR     =>   Result<= A or B;  --or
            WHEN ALU_NOR     =>   Result<= not(A or B);  --or
            WHEN ALU_XOR    =>   Result<= A xor B;  --xor
            WHEN ALU_SLR    =>   Result<= '0' & A(BitWidth-1 downto 1) ;  --shift right
            WHEN ALU_SLL    =>   Result<= A(BitWidth-2 downto 0)& '0' ;  --shift left
            WHEN ALU_NEG_A  =>   Result<= not A +1;  --negation
            WHEN ALU_SAR    =>   Result<= A(BitWidth-1) & A(BitWidth-1 downto 1) ;  --shift right Arith
            WHEN ALU_SAL    =>   Result<= A(BitWidth-1) & A(BitWidth-3 downto 0)& A(0) ;  --shift left Arith
            WHEN ALU_FLIP_A  =>   Result<= not(A); --Not of A
            WHEN ALU_CLR_A  =>   Result<= (others => '0'); --Clear ACC
            WHEN ALU_RRC    =>   Result<= Cflag_in & A(BitWidth-1 downto 1); -- RRC
            WHEN ALU_RLC    =>   Result<= A(BitWidth-2 downto 0)& Cflag_in ; -- RLC
       WHEN OTHERS => Result<= (others => '0');
    END CASE;

 end process PROC_ALU;

end RTL;
