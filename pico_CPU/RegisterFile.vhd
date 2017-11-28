 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

entity RegisterFile is
generic (BitWidth: integer);
  port ( clk : in std_logic;
			rst: in std_logic;
			Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_CU: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_ACC: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_sel: in std_logic_vector (1 downto 0);
			Register_in_sel: in std_logic_vector (7 downto 0);
			Register_out_sel: in std_logic_vector (2 downto 0);
			Data_out: out std_logic_vector (BitWidth-1 downto 0)
  );
end RegisterFile;

architecture Behavioral of RegisterFile is
Signal R0_in,R0_out: std_logic_vector (BitWidth-1 downto 0);
Signal R1_in,R1_out: std_logic_vector (BitWidth-1 downto 0);
Signal R2_in,R2_out: std_logic_vector (BitWidth-1 downto 0);
Signal R3_in,R3_out: std_logic_vector (BitWidth-1 downto 0);
Signal R4_in,R4_out: std_logic_vector (BitWidth-1 downto 0);
Signal R5_in,R5_out: std_logic_vector (BitWidth-1 downto 0);
Signal R6_in,R6_out: std_logic_vector (BitWidth-1 downto 0);
Signal R7_in,R7_out: std_logic_vector (BitWidth-1 downto 0);
signal Data_in: std_logic_vector (BitWidth-1 downto 0);
begin
process (clk,rst)begin
	if rst = '1' then 
		R0_out <= (others=>'0');
		R1_out <= (others=>'0');
		R2_out <= (others=>'0');
		R3_out <= (others=>'0');
		R4_out <= (others=>'0');
		R5_out <= (others=>'0');
		R6_out <= (others=>'0');
		R7_out <= (others=>'0');
	elsif clk'event and clk='1' then 
		R0_out <= R0_in;
		R1_out <= R1_in;
		R2_out <= R2_in;
		R3_out <= R3_in;
		R4_out <= R4_in;
		R5_out <= R5_in;
		R6_out <= R6_in;
		R7_out <= R7_in;
	end if;
end process;


process(Data_in_mem,Data_in_CU,Data_in_ACC,Data_in_sel)begin
 case Data_in_sel is 
	when "01" => Data_in <= Data_in_CU;
	when "10" => Data_in <= Data_in_ACC;
	when "11" => Data_in <= Data_in_mem;
	when others => Data_in <= (others=>'0');
 end case;
end process;

process(Data_in ,Register_in_sel,R7_out,R6_out,R5_out,R4_out,R3_out,R2_out,R1_out,R0_out)begin

	if Register_in_sel(0) = '0' then 
		R0_in <= R0_out;
	else
		R0_in <= Data_in;
	end if;
	
	if Register_in_sel(1) = '0' then 
		R1_in <= R1_out;
	else
		R1_in <= Data_in;
	end if;
	
	if Register_in_sel(2) = '0' then 
		R2_in <= R2_out;
	else
		R2_in <= Data_in;
	end if;
	
	if Register_in_sel(3) = '0' then 
		R3_in <= R3_out;
	else
		R3_in <= Data_in;
	end if;
	
	if Register_in_sel(4) = '0' then 
		R4_in <= R4_out;
	else
		R4_in <= Data_in;
	end if;
	
	if Register_in_sel(5) = '0' then 
		R5_in <= R5_out;
	else
		R5_in <= Data_in;
	end if;

	if Register_in_sel(6) = '0' then 
		R6_in <= R6_out;
	else
		R6_in <= Data_in;
	end if;

	if Register_in_sel(7) = '0' then 
		R7_in <= R7_out;
	else
		R7_in <= Data_in;
	end if;	
end process;

process (Register_out_sel,R7_out,R6_out,R5_out,R4_out,R3_out,R2_out,R1_out,R0_out)begin
 case Register_out_sel is 
	when "000" => Data_out<= R0_out;
	when "001" => Data_out<= R1_out;
	when "010" => Data_out<= R2_out;
	when "011" => Data_out<= R3_out;
	when "100" => Data_out<= R4_out;
	when "101" => Data_out<= R5_out;
	when "110" => Data_out<= R6_out;
	when "111" => Data_out<= R7_out; 
	when others => Data_out<= (others =>'0');
 end case;
end process;
end Behavioral;

