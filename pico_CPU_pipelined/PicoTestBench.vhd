library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use work.pico_cpu.all;

entity PicoCPUTestBench is
end PicoCPUTestBench;

architecture Bench of PicoCPUTestBench is

  --Component declaration for ALU


 signal clk: std_logic:= '0';
 signal rst: std_logic:= '1';

begin

--Component instantiation of ALU
PicoCPU_comp: PicoCPU port map (rst, clk);

process
begin
  clk <= '0';
  wait for clock_period/2;
  clk <= '1';
  wait for clock_period/2;
end process;

process
begin
  rst <= '1';
  wait for 2.5*clock_period;
  rst <=  '0';
  wait;
end process;


end Bench;
