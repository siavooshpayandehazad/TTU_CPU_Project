library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use work.pico_cpu.all;

entity PicoCPUTestBench is
end PicoCPUTestBench;

architecture Bench of PicoCPUTestBench is

  --Component declaration for ALU


 signal clk: std_logic:= '0';
 signal rst: std_logic:= '0';
 signal IO: std_logic_vector(CPU_Bitwidth-1 downto 0):= (others => 'Z');

begin

--Component instantiation of ALU
PicoCPU_comp: PicoCPU
            generic map (Mem_preload_file => "code.txt")
            port map (rst, clk, IO => IO);

CLOCK_GEN:process
begin
  clk <= '0';
  wait for clock_period/2;
  clk <= '1';
  wait for clock_period/2;
end process;

RST_GEN:process
begin
  rst <= '1';
  wait for 0.5*clock_period;
  rst <=  '0';
  wait;
end process;

IO <= "00000000000000000000000000000001" after 36.5 ns;
end Bench;
