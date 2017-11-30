
library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity InstMem is
  generic (BitWidth: integer;
           InstructionWidth: integer);
  port ( address : in std_logic_vector(BitWidth-1 downto 0);
         data : out std_logic_vector(InstructionWidth-1 downto 0) );
end entity InstMem;

architecture behavioral of InstMem is

  type mem is array ( 0 to InstMem_depth-1) of std_logic_vector(InstructionWidth-1 downto 0);

  constant my_InstMem : mem := (
0  =>   "10000100000000000000000000000000011000",--Load_R0_Dir   R0 = 24
1  =>   "00111100000000000000000000000000000000",--OR_A_R0       ACC = 24
2  =>   "00011000000000000000000000000000000000",--IncA         ACC = 25
3  =>   "00001100000000000000000000000000000000",--Sub_A_R0      ACC = 1
4  =>   "11111000000000000000000000000000000000",--NOP
5  =>   "01011000000000000000000000000000000111",--JmpC 7        Jump
6  =>   "00011000000000000000000000000000000000",--IncA         should be skipped!
7 =>    "00110000000000000000000000000000000000",--RRC
8 =>    "00110100000000000000000000000000000000",--RLC          ACC = 1
9 =>    "11111000000000000000000000000000000000",--NOP
10 =>   "01101100000000000000000000000000000000",--ClearC
11 =>   "10000000000000000000000000000000010000",--Store_A_Mem   MEM[16] = 1
12 =>   "11110000000000000000000000000000000000",--PUSH
13 =>   "01111000000000000000000000000000000000",--SavePC
14 =>   "11110000000000000000000000000000000000",--PUSH
15 =>   "01001100000000000000000000000000010101",--Jmp 21
16 =>   "00011000000000000000000000000000000000",--IncA         should be skipped!
17 =>   "11110100000000000000000000000000000000", --pop
18 =>   "00100100000000000000000000000000000000", --ShiftArithL
19 =>   "00011100000000000000000000000000000000",--DecA
20 =>   "11111100000000000000000000000000000000", --HALT
21 =>   "01111100000000000000000000000000010000",--Load_A_Mem
22 =>   "00111000000000000000000000000000000000",--AND
23 =>   "01010000000000000000000000000000011010",--JMPZ 26
24 =>   "01101100000000000000000000000000000000",--ClearZ
25 =>   "00000100000000000000000000000000010000",--Add_A_Mem
26 =>   "00010000000000000000000000000000010000",--Sub_A_Mem
27 =>   "00000000000000000000000000000000000000",--ADD_A_B
28 =>   "00010100000000000000000000000000001100",--SUB_A_DIR C
29 =>   "01000100000000000000000000000000000000",--FlipA
30 =>   "01000000000000000000000000000000000000",--XOR_A_B
31 =>   "01001000000000000000000000000000000000",--NegA
32 =>   "00100000000000000000000000000000000000",--ShiftArithR
33 =>   "00101100000000000000000000000000000000",--ShiftA_L
34 =>   "00101000000000000000000000000000000000",--ShiftA_R
35 =>   "10011000000000000000000000000000000001",--GPIO_DIR               SET GPIO AS OUTPUT
36 =>   "10100000000000000000000000000000101010",--GPIO_WR               SET GPIO AS OUTPUT
37 =>   "01110000000000000000000000000000000000",--ClearACC
38 =>   "10011000000000000000000000000000000000",--GPIO_DIR               SET GPIO AS in
39 =>    "11111000000000000000000000000000000000",--NOP
40 =>   "10011100000000000000000000000000000000",--GPIO_RD               SET GPIO AS OUTPUT
41 =>   "11110100000000000000000000000000000000",--POP
42 =>   "00001000000000000000000000000000000110",--Add_A_Dir
43 =>   "01110100000000000000000000000000000000",--LoadPC
others => "00000000000000000000000000000000000000"
    );


begin
  process(address)begin
    if to_integer(unsigned(address)) <= InstMem_depth-1 then
      data <= my_InstMem(to_integer(unsigned(address)));
    else
      data <= (others => '0');
    end if;
  end process;
end architecture behavioral;
