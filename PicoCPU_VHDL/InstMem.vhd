
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
---------------------------------------------
--------------CODE FOR CALCULATOR------------        
---------------------------------------------

0 =>   "01001100001101",--JMP TO load to registers 13
-- COMMMANDS:
--ADD
1 =>   "10001100000000",	--LOAD_R0_A		OP1 -> A
2 =>   "00000000000001",	--ADD_A_R		OP2 + OP2
3 =>   "01001100110111",	--jmp HALT
--AND
4 =>   "10001100000000",	--LOAD_A_R		OP1 -> A
5 =>   "00111000000001",	--AND_A_R		OP1 & OP2
6 =>   "01001100110111",	--jmp HALT
--OR
7 =>   "10001100000000",	--LOAD_A_R		OP1 -> A
8 =>   "00111100000001",	--OR_A_R 		OP1 | OP2
9 =>    "01001100110111",  --jmp HALT
--SUB
10 =>   "10001100000000",--LOAD_R_A	OP1 -> A
11 =>   "00001100000001",--SUB_A_R		OP1 - OP2
12 =>   "01001100110111",--jmp HALT

-- Load to registers:
13 =>   "00001000000011",--ADD_A_DIR	MASK1 "00000011" OP2
14 =>   "10010000000100",--LOAD_R_A	A->R2
15 =>   "01110000000000",--CLEAR ACC

--16 =>   "",--LOAD_R0_DIR	MASK2 "00001100" OP1 -> R3

16 =>   "00001000001100",--ADD_A_DIR	MASK1 "00001100" OP1
17 =>   "10010000001000",--LOAD_R_A	A->R3
18 =>   "01110000000000",--CLEAR ACC

19 =>   "00001000010000",--ADD_A_DIR	MASK3 "00010000" COMMAND OR
20 =>   "10010000010000",--LOAD_R_A	A->R4
21 =>   "01110000000000",--CLEAR ACC

22 =>   "00001000100000",--ADD_A_DIR	MASK4 "00100000" COMMAND AND
23 =>   "10010000100000",--LOAD_R_A	A->R5
24 =>   "01110000000000",--CLEAR ACC

25 =>   "00001001000000",--ADD_A_DIR	MASK5 "01000000" COMMAND SUB
26 =>   "10010001000000",--LOAD_R_A	A->R6
27 =>   "01110000000000",--CLEAR ACC

28 =>   "00001010000000",--ADD_A_DIR	MASK5 "10000000" COMMAND ADD
29 =>   "10010010000000",--LOAD_R_A	A->R7
30 =>   "01110000000000",--CLEAR ACC

--Load operands from memory to registers
31 =>   "01111111111111",--LOAD_A_MEM 	0xff -> A
32 =>   "00111000000010",--AND_A_R  		0xff & R2 -- A=OP2
33 =>   "10010000000010",--LOAD_R_A R1   R1=OP2

34 =>   "01111111111111",--LOAD_A_MEM 	0xff -> A
35 =>   "00111000000011",--AND_A_R  		0xff & R3
36 =>	  "00101000000000", -- ShiftA_R
37 =>	  "00101000000000", -- ShiftA_R
38 =>   "10010000000001",--LOAD_R_A      R0=OP1

-- Check which operation is selected
-- OR --
39 =>   "01111111111111",--LOAD_A_MEM		 0xff -> A
40 =>   "00111000000100",--AND_A_R  		0xff & R4
41 =>   "01010000101011",--JMPZ PC+2
42 =>   "01001100000111",--jmp OR function7
-- AND --
43 =>   "01111111111111",--LOAD_A_MEM		 0xff -> A
44 =>   "00111000000101",--AND_A_R  		0xff & R5
45 =>   "01010000101111",--JMPZ --	 jmpto SUB
46 =>   "01001100000100",--jmp AND function 4
-- SUB --
47 =>   "01111111111111",--LOAD_A_MEM		 0xff -> A
48 =>   "00111000000110",--AND_A_R  		0xff & R6
49 =>   "01010000110011",--JMPZ --	 jmpto ADD
50 =>   "01001100001010",--jmp SUB function 10
-- ADD --
51 =>   "01111111111111",--LOAD_A_MEM		 0xff -> A
52 =>   "00111000000111",--AND_A_R  		0xff & R7
53 =>   "01010000110111",--JMPZ --	 jmpto HALT
54 =>   "01001100000001",--jmp ADD function 1
--STOP--
55 =>   "11111100000000",--HALT
others => "00000000000000"
);
begin
  
  data <= my_InstMem(to_integer(unsigned(address)));

  
end architecture behavioral;