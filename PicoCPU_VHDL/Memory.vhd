library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;
use ieee.std_logic_unsigned.all; 

entity Mem is 
	generic (BitWidth: integer := 16);
	port ( 
		clk				: in 	STD_LOGIC;
		rst				: in 	STD_LOGIC;
		RW				: in 	STD_LOGIC;
	    RdAddress		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		Data_in			: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		WrtAddress		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
		Tabloo_Addr		: in 	STD_LOGIC_VECTOR (5 downto 0);
		data_ready		: out 	STD_LOGIC;	
		Tabloo_Data		: out 	STD_LOGIC_VECTOR (7 downto 0);
		Data_Out		: out	STD_LOGIC_VECTOR (BitWidth-1 downto 0) 
	);
end Mem;

architecture beh of Mem is

	component slow_clock is
		Port ( clk_in 		: in 	STD_LOGIC;
			rst 			: in 	STD_LOGIC;
			slow_clk_out 	: out 	STD_LOGIC);
	end component slow_clock;

	type Mem_type is array (0 to (2**8)-1) of STD_LOGIC_VECTOR(BitWidth-1 downto 0);
	signal Mem : Mem_type;
	
	signal mem_pos : std_logic_vector(6 downto 0) := (others => '0'); -- counter for memory iteration 
	signal value_counter : std_logic_vector(7 downto 0) := "00000001" ;
	
	signal data_ready_i : std_logic := '0';
	signal slow_clk : std_logic := '0';
	signal load_mem : std_logic := '0';
	signal stop_load_mem : std_logic := '0';
	signal load_mem_done : std_logic := '0';

begin
	
	--sc : slow_clock port map (clk, rst, slow_clk); 

	--process(data_ready_i, rst, stop_load_mem)
	--begin
	--	if rst = '1' then 
	--		value_counter <= "00000001" ;
	--	elsif rising_edge(data_ready_i) and stop_load_mem = '0' then 
	--		value_counter <= value_counter + 1 ;
	--	end if;
	--end process;

	--datardy: process(rst,clk)
	--begin
	--	if rst = '1' then 
	--		load_mem <= '0';
	--	elsif rising_edge(clk) then 
	--		if stop_load_mem = '0' then 
	--			load_mem <= '1';
	--		else 
	--			load_mem <= '0';
	--		end if;
	--	end if;
	--end process;

	----------------------------------
	-- Memory process 
	----------------------------------

	MemProcess: process(clk,rst) is
	begin
		if rst = '1' then 
			Mem<= ((others=> (others=>'0')));

			stop_load_mem <= '0';
			mem_pos <= (others => '0');
		elsif rising_edge(clk) then
			if RW = '1' then
				Mem(to_integer(unsigned(WrtAddress(BitWidth-1 downto 0)))) <= Data_in;
			end if;

			--if load_mem = '1' then
			--	Mem(to_integer(unsigned(mem_pos)) + 191) <= value_counter; 
			--	data_ready_i <= '1'; 

			--	if mem_pos = "1000000" then
			--		stop_load_mem <= '1';
			--		mem_pos <= (others => '0');
			--	else
			--		mem_pos <= mem_pos + 1 ;
			--	end if;
			--else
			--	data_ready_i <= '0';
			--end if ;
		end if;
	end process MemProcess;

--	data_ready 	<= data_ready_i;
	data_ready 	<= Mem(190)(0);
	Data_Out 	<= Mem(to_integer(unsigned(RdAddress(BitWidth-1 downto 0))));
	Tabloo_Data <= Mem(to_integer(unsigned(Tabloo_Addr))+191)(7 downto 0);
	
end beh;