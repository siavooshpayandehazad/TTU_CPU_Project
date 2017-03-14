 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity TopLevel is
	port(
	 rst: in std_logic;
    clk: in std_logic;
	 ClkBttn: in std_logic;
	 SwitchInput: in std_logic_vector(7 downto 0);
	 AN: 			out std_logic_vector(3 downto 0);
    SevenSeg: 	out std_logic_vector(6 downto 0);
	 		update_mux 	: out 	STD_LOGIC;
		Mux 		: out 	STD_LOGIC_VECTOR (3 downto 0);
		NegPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
		PosPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
	 FlagOutput: out std_logic_vector ( 3 downto 0)
	 );
end TopLevel;

architecture Behavioral of TopLevel is

component PicoCPU is
  port(
    rst: in std_logic;
    clk: in std_logic;
	 SwitchIn : in std_logic_vector(7 downto 0);
	 update_mux 	: out 	STD_LOGIC;
	 Mux 		: out 	STD_LOGIC_VECTOR (3 downto 0);
	 NegPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
		PosPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
	 FlagOut: out std_logic_vector (3 downto 0);
	 output: out std_logic_vector (15 downto 0)
  );
end component;

component Debouncer is
    Port ( rst : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           ClkBtn_in : in  STD_LOGIC;
           ClkBtn_out : out  STD_LOGIC);
end component;

component slow_clock is
    Port ( clk_in : in  STD_LOGIC;
				rst : in  STD_LOGIC;
           slow_clk_out : out  STD_LOGIC);
end component;

component VectorToSevenSeg is
port( clk: 			in std_logic;
		InputVector:in  std_logic_vector (15 downto 0);
		AN: 			out std_logic_vector(3 downto 0);
		SevenSeg: 	out std_logic_vector(6 downto 0)
);
end component;

component IO_controller is
Port ( clk : in  std_logic;
           Switch_in : in  std_logic_vector (7 downto 0);
           IO_data_out : out  std_logic_vector (7 downto 0)
);
end component;

signal ClkBtnout : STD_LOGIC;
signal SystemClk: std_logic;
constant  ClockSrc: std_logic := '1'; 
signal FlagOut: std_logic_vector (3 downto 0);
signal IO_Out: std_logic_vector (7 downto 0);
signal ALUVal: std_logic_vector (15 downto 0);
begin
Debouncer_comp: Debouncer  port map (rst,clk,ClkBttn,ClkBtnout);
PicoCPU_comp: PicoCPU  port map (rst,SystemClk,IO_out,update_mux,Mux,NegPin,	PosPin,FlagOut,ALUVal);
SevSeg_comp: VectorToSevenSeg port map (clk,ALUVal,AN,SevenSeg);
IO_comp: IO_Controller port map(clk,SwitchInput,IO_out);
slow_clk: slow_clock port map(clk, rst, SystemClk);
---------------------------------------------
--      Clock Source
---------------------------------------------
--process(clk,ClkBtnout)begin
--	if(ClockSrc='1')then
--		SystemClk<= ClkBtnout;
--	else
--		SystemClk<= clk;
--	end if;
--end process;
--SystemClk<= clk;

FlagOutput(3 downto 0) <= 	FlagOut;
end Behavioral;

