library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IO_Controller is
    Port ( clk : in  std_logic;
           Switch_in : in  std_logic_vector (7 downto 0);
           IO_data_out : out  std_logic_vector (7 downto 0));
end IO_Controller;

architecture Behavioral of IO_Controller is

begin

process(clk) begin
	if clk'event and clk ='1' then 
			 IO_data_out <= Switch_in; 
	end if; 
end process; 

end Behavioral;

