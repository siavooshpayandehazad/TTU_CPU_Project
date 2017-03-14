library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IO_comp is
    Port ( clk : in  std_logic;
           Switch_in : in  std_logic_vector (3 downto 0);
           IO_data_out : out  std_logic_vector (3 downto 0));
end IO_comp;

architecture Behavioral of IO_comp is

begin


end Behavioral;
