----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:	12:07:21 10/19/2016 
-- Design Name: 
-- Module Name:	Tabloo_driver - Behavioral 
-- Project Name: 
-- Target Devices: 

-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--

	---------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------|      |---
	--------------                                                                       ---|      |---
	--------------                            Tabloo Driver                              ---|      |---
	--------------                                                                       ---|      |---
	----------------------------------------------------------------------------------------|      |---
	---------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_MISC.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Tabloo_driver is
	Port ( clk, rst 		: in  STD_LOGIC;
			Refresh_data	: in  STD_LOGIC;
			Tabloo_Mem_Data	: in  STD_LOGIC_VECTOR(7 downto 0);
			update_mux		: out STD_LOGIC;
			Tabloo_Mem_Addr	: out STD_LOGIC_VECTOR(5 downto 0);
			Tabloo_Mux		: out STD_LOGIC_VECTOR(3 downto 0);
			Tabloo_NegPin	: out STD_LOGIC_VECTOR(7 downto 0);
			Tabloo_PosPin	: out STD_LOGIC_VECTOR(7 downto 0));
end Tabloo_driver;

architecture Behavioral of Tabloo_driver is

	component decoder is
		port( sel 	: in  STD_LOGIC_VECTOR (2 downto 0);
			y		: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;

	--------------------------------
	----------   Buffer   ----------
	--------------------------------

	type Mem_type is array (0 to 7, 0 to 7, 0 to 7) of STD_LOGIC;
	signal temp : Mem_type := (others => (others => (others => '0')));

	--------------------------------
	----------  /Buffer   ----------
	--------------------------------

	type 	state_pos_type				is ( SP_Pre, SP_Begin, SP_Assign1, SP_Assign2, SP_Assign3, SP_End, SP_Wait );
	signal	PFSM_state, PFSM_next		: state_pos_type;

	signal	load_mem_ena, load_mem_done	: STD_LOGIC;
	signal 	counter, counter_n			: STD_LOGIC_VECTOR (5 downto 0);

	signal	wait_done					: STD_LOGIC;	
	signal	update_mux_t				: STD_LOGIC;	
	
	signal	OE_inv						: STD_LOGIC;	
	signal 	Mux_var_t					: STD_LOGIC_VECTOR (2 downto 0);
	signal 	Mux_var						: STD_LOGIC_VECTOR (2 downto 0);
	signal	PosPin_var					: STD_LOGIC_VECTOR (7 downto 0);
	signal 	counter_upd, counter_upd_n	: STD_LOGIC_VECTOR (3 downto 0);
	signal 	counter_wait, counter_wait_n: STD_LOGIC_VECTOR (5 downto 0);

	signal  NegPin_ena					: STD_LOGIC;
	signal	NegVal, NegVal_n			: STD_LOGIC_VECTOR (2 downto 0);
	signal	NegPin_var, NegPin_var_out	: STD_LOGIC_VECTOR (7 downto 0);

	function reverse_any_vector (s1:std_logic_vector) return std_logic_vector is 
		variable rr : std_logic_vector(s1'high downto s1'low); 
	begin 
		for ii in s1'high downto s1'low loop 
			rr(ii) := s1(s1'high-ii); 
		end loop; 
		return rr; 
	end reverse_any_vector;  -- function reverse_any_vector

begin
	---------------------------------------------------------------------------------------------------
	--------------  Data load in from Memeory                                            --------------
	---------------------------------------------------------------------------------------------------

	enable_upload : process( clk, rst, Refresh_data, load_mem_done )
	begin 
		if rst = '1' then 
			load_mem_ena <= '0';
		elsif rising_edge( clk ) then
			if load_mem_done = '1' then 
				load_mem_ena <= '0';
			elsif Refresh_data = '1' then 
				load_mem_ena <= '1';
			end if ;
		end if ;
	end process ; -- enable_upload

	load_mem_done <= and_reduce(counter);

	update_data_from_memory : process( load_mem_ena, clk, rst ) 
	begin 
		if rst = '1' or load_mem_ena = '0' then
			counter <= STD_LOGIC_VECTOR (to_unsigned(0, 6));
		elsif rising_edge(clk) and load_mem_ena = '1' then
			memory_vetor_load : for i in 0 to 7 loop
				temp(i, to_integer(unsigned(counter(5 downto 3))),
						to_integer(unsigned(counter(2 downto 0)))) <= Tabloo_Mem_Data(i);
			end loop ; -- memory_vetor_load
			counter <= counter_n;
		end if; 
	end process ; -- update_data_from_memory

	counter_n <= counter + 1;

	---------------------------------------------------------------------------------------------------
	--------------  Long wait                 |||   S_display  |||                       --------------
	---------------------------------------------------------------------------------------------------

	long_wait : process( clk, rst, PFSM_state, counter_wait_n) 
	begin
		if rst = '1' then
			counter_wait <= STD_LOGIC_VECTOR (to_unsigned(0, 6));
			wait_done <= '0';
		elsif rising_edge(clk) and PFSM_state = SP_wait then
			if and_reduce(counter_wait) = '1' then
				counter_wait <= STD_LOGIC_VECTOR (to_unsigned(0, 6));
				wait_done <= '1';
			else
				counter_wait <= counter_wait_n;
				wait_done <= '0';
			end if ;
		end if ;
	end process ; -- long_wait

	counter_wait_n <= counter_wait + 1;

	---------------------------------------------------------------------------------------------------
	--------------  Refresh Display           |||   S_update   |||                       --------------
	---------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------------
	------ Row select ------
	---------------------------------------------------------------------------------------------------

	Inrement_NegPin_sel : process( rst, clk )
	begin 
		if rst = '1' then 
			NegVal <= STD_LOGIC_VECTOR (to_unsigned(0, 3));
		elsif rising_edge(clk) then
			if SP_End = PFSM_state then
				NegVal <= NegVal_n;
			end if ;
		end if ;
	end process ; -- Inrement_NegPin_sel
			
	NegVal_n <= NegVal + 1;

	row_enable : process( clk, rst, OE_inv ) 
	begin
		if rst = '1' then
			NegPin_var_out <= STD_LOGIC_VECTOR (to_unsigned(0, 8));
		elsif rising_edge(clk) then
			if NegPin_ena = '1' then
				NegPin_var_out <= NegPin_var;
			else
				NegPin_var_out <= STD_LOGIC_VECTOR (to_unsigned(0, 8));
			end if ;
		end if ;
	end process ; -- row_enable
	---------------------------------------------------------------------------------------------------



	---------------------------------------------------------------------------------------------------
	------ Display FSM --------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	Display_update_next_state_FSM : process( rst, PFSM_state, counter_upd(3), wait_done ) 
	begin
		if rst = '1' then
			PFSM_next <= SP_Begin;
		else 
			case( PFSM_state ) is 
				when SP_Pre => 
					PFSM_next <= SP_Begin;
				when SP_Begin => 
					PFSM_next <= SP_Assign1;
				when SP_Assign1 =>
					if counter_upd(3) = '1' then
						PFSM_next <= SP_End;
					else
						PFSM_next <= SP_Assign2;
					end if;
				when SP_Assign2 =>
						PFSM_next <= SP_Assign3;
				when SP_Assign3 =>
						PFSM_next <= SP_Assign1;
				when SP_End =>
					PFSM_next <= SP_Wait;
				when SP_Wait =>
					if wait_done = '1' then
						PFSM_next <= SP_Pre;
					else 
						PFSM_next <= SP_Wait;
					end if ;
			end case ;
		end if ;
	end process ; -- Display_update_FSM

	Display_update_FSM : process( clk )
	begin
		if rising_edge(clk) then
			PFSM_state <= PFSM_next;
		end if ;
	end process ; -- Display_update_FSM
	---------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------------
	------ Display update States ------
	---------------------------------------------------------------------------------------------------
	Display_assignments : process( rst, clk, PFSM_state, counter_upd )
	begin
		if rst = '1' then
			OE_inv <= '1';
			update_mux_t <= '0';
		elsif rising_edge(clk) then 
			case( PFSM_state ) is 
				when SP_Pre =>
				when SP_Begin => 
					NegPin_ena <= '0';

					counter_upd <= STD_LOGIC_VECTOR (to_unsigned(0, 4));
				when SP_Assign1 =>
					PosPin_setup : for i in 0 to 7 loop 
						PosPin_var(i) <= temp(to_integer(unsigned(NegVal)), 
						                   	to_integer(unsigned(counter_upd(2 downto 0))), i);
					end loop ; -- PosPin_setup
					Mux_var <= counter_upd(2 downto 0);
				when SP_Assign2 =>
					update_mux_t <= '0';
					OE_inv <= '1';
					counter_upd <= counter_upd_n;
				when SP_Assign3 =>
					update_mux_t <= '1';
				when SP_End =>
					Mux_var <= STD_LOGIC_VECTOR (to_unsigned(0, 3));
					OE_inv <= '0';
					NegPin_ena <= '1';
				when SP_Wait =>
				end case ;
		end if ;
	end process ; -- Assignments

	counter_upd_n <= counter_upd + 1;

	---------------------------------------------------------------------------------------------------
	--------------  External components                                                  --------------
	---------------------------------------------------------------------------------------------------

	decoder_comp: decoder 
		port map(NegVal, NegPin_var);

	---------------------------------------------------------------------------------------------------
	--------------  Output assignment                                                    --------------
	---------------------------------------------------------------------------------------------------

	Tabloo_Mem_Addr <= counter;
	Tabloo_NegPin 	<= NegPin_var_out;
	Tabloo_PosPin 	<= PosPin_var;
	Tabloo_Mux		<= OE_inv & Mux_var;
	update_mux 		<= update_mux_t;

end Behavioral;


	--------------------------------
	----------   Decoder  ----------
	--------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
	Port ( sel 	: in  STD_LOGIC_VECTOR(2 downto 0);
			y	: out STD_LOGIC_VECTOR(7 downto 0)
	);
end decoder;

architecture Behavioral of decoder is
begin
	with sel select
		y <="10000000" when "000",
			"00000001" when "001",
			"00000010" when "010",
			"00000100" when "011",
			"00001000" when "100",
			"00010000" when "101",
			"00100000" when "110",
			"01000000" when others;
end Behavioral;

