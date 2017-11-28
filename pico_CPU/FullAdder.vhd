library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FullAdderSub is
    Port ( C_in : in  STD_LOGIC;
           A : in  STD_LOGIC;
           B : in  STD_LOGIC;
	   Add_Sub: in STD_LOGIC;
           C_out : out  STD_LOGIC;
           Sum : out  STD_LOGIC);
end FullAdderSub;

architecture Behavioral of FullAdderSub is

---------------------------------------------
--      Signals
---------------------------------------------
 signal NewB : std_logic;
---------------------------------------------
begin

NewB <= b xor Add_Sub; --this line is for changing from add to subtract. its add when Add_Sub = 0 otherwise its sub

Sum <= a xor NewB xor C_in;

C_out  <= (a and NewB) or ((a xor NewB) and C_in);

end Behavioral;


