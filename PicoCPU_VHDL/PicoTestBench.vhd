


library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL; 

entity PicoCPUTestBench is
end PicoCPUTestBench;

architecture Bench of PicoCPUTestBench is

  --Component declaration for ALU
 Component PicoCPU is
  port(
   
    rst: in std_logic;
    clk: in std_logic;
	 SwitchIn : in std_logic_vector(7 downto 0);
	 FlagOut: out std_logic_vector ( 3 downto 0);
	 output: out std_logic_vector (15 downto 0)
  );
end Component; 
 
 signal clk: std_logic:= '0';
 signal rst: std_logic:= '1';
 signal SwitchIn : std_logic_vector(7 downto 0);
 signal FlagOut : std_logic_vector ( 3 downto 0);
 signal output: std_logic_vector ( 15 downto 0);
begin

--Component instantiation of ALU
PicoCPU_comp: PicoCPU port map (rst, clk,SwitchIn, FlagOut, output);
 SwitchIn <= "00011100";
 clk <= not clk after 5 ns;
 rst <=  '0' after 3 ns;
 
 end Bench;

