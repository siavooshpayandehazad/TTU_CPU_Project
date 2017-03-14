library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity slow_clock is
    Port ( clk_in : in  STD_LOGIC;
				rst : in  STD_LOGIC;
           slow_clk_out : out  STD_LOGIC);
end slow_clock;

architecture Behavioral of slow_clock is

  signal prescaler : unsigned(23 downto 0) := (others => '0');
  signal clk_scaled : std_logic := '0';
begin

 gen_clk : process (clk_in, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_scaled   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_in) then   -- rising clock edge
      if prescaler = X"001FF" then
--      if prescaler = X"0000FF" then    
        prescaler   <= (others => '0');
        clk_scaled   <= '1';
      else
        clk_scaled   <= '0';
        prescaler <= prescaler + 1;
      end if;
    end if;
 end process gen_clk;

slow_clk_out <= clk_scaled;

end Behavioral;

