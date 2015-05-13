
library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity InstMem is
  generic (BitWidth: integer;
           InstructionWidth: integer);
  port ( address : in std_logic_vector(BitWidth-1 downto 0);
         data : out std_logic_vector(InstructionWidth-1 downto 0) );
end entity InstMem;

architecture behavioral of InstMem is
  
  type mem is array ( 0 to (2**BitWidth)-1) of std_logic_vector(InstructionWidth-1 downto 0);
  
  constant my_InstMem : mem := (
0 =>   "10000100011000",--Load_B_Dir
1 =>   "00111100000000",--OR_A_B
2 =>   "00011000000000",--IncA
3 =>   "00001100000000",--Sub_A_B
4 =>   "01011000000111",--JmpC 7
5 =>   "11111011110000",--NOP
6 =>   "11111000000000",--NOP
7 =>   "00110000000000",--RRC
8 =>   "00110100000000",--RLC
9 =>    "11111000000000",--NOP
10 =>   "01101100000000",--ClearC
11 =>   "10000000010000",--Store_A_Mem
12 =>   "11110000000000",--PUSH
13 =>   "01111000000000",--SavePC
14 =>   "11110000000000",--PUSH
15 =>   "01001100010100",--Jmp 20
16 =>   "11110100000000", --pop
17 =>   "00100100000000", --ShiftArithL
18 =>   "00011100000000",--DecA
19 =>   "11111100000000", --HALT
20 =>   "01111100010000",--Load_A_Mem
21 =>   "00111000000000",--AND 
22 =>   "01010000011000",--JMPZ 24
23 =>   "11111000000000",--NOP
24 =>   "01101100000000",--ClearZ
25 =>   "00000100010000",--Add_A_Mem
26 =>   "00010000010000",--Sub_A_Mem
27 =>   "00000000000000",--ADD_A_B
28 =>   "00010100001100",--SUB_A_DIR C
29 =>   "01000100000000",--FlipA
30 =>   "01000000000000",--XOR_A_B
31 =>   "01001000000000",--NegA
32 =>   "00100000000000",--ShiftArithR
33 =>   "00101100000000",--ShiftA_L
34 =>   "00101000000000",--ShiftA_R
35 =>   "01110000000000",--ClearACC
36 =>   "11110100000000",--POP
37 =>   "00001000000011",--Add_A_Dir
38 =>   "01110100000000",--LoadPC
others => "00000000000000"
    );
    

begin
  
  data <= my_InstMem(to_integer(unsigned(address)));

  
end architecture behavioral;