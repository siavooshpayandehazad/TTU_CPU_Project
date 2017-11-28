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

 clk <= not clk after 1 ns;
 rst <=  '0' after 3 ns;





end Bench;
