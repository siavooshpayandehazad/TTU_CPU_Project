 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL; 

 

entity Debouncer is
    Port ( rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           ClkBtn_in : in  STD_LOGIC;
           ClkBtn_out : out  STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
   signal counter,counter_in: STD_LOGIC_VECTOR (10 downto 0);
	signal ShiftReg: STD_LOGIC_VECTOR (2 downto 0);
begin
  process(clk,rst)begin
		if rst= '1' then 
			counter <= "00000000000";
		elsif clk'event and clk ='1' then 
			counter <= counter_in;
		end if;
  end process;
  
  counter_in <= counter+1;
  
  process(counter(10),ClkBtn_in)begin
		if counter(10)'event and counter(10)='1' then
      ShiftReg(0)<= ClkBtn_in;
		ShiftReg(1)<= ShiftReg(0);
		ShiftReg(2)<= ShiftReg(1);
		end if;
  end process;
  
  process(ShiftReg)begin
	if ShiftReg = "100" then
		ClkBtn_out <= '1';
	else
	   ClkBtn_out <= '0';
	end if;
  end process;
end Behavioral;

