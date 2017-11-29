library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
 USE IEEE.NUMERIC_STD.ALL;
use work.pico_cpu.all;

--Adder entity
entity  Adder_Sub is
  generic (BitWidth: integer);
  port (
        A: in std_logic_vector (BitWidth-1 downto 0);
        B: in std_logic_vector (BitWidth-1 downto 0);
        Add_Sub: in std_logic;
        result: out std_logic_vector (BitWidth-1 downto 0);
        Cout: out std_logic
    );
end Adder_Sub;

--Architecture of the Adder
architecture RTL of Adder_Sub is
---------------------------------------------
--      Signals
---------------------------------------------
signal   carry : std_logic_vector (bitwidth downto 0) := (others => '0');
---------------------------------------------
begin


carry(0) <= Add_Sub;

---------------------------------------------
--      component instantiation
---------------------------------------------
g_counter: for N in 0 to bitwidth-1 generate
    ADDN : FullAdderSub port map (carry(N),A(N),B(N),Add_Sub,carry(N+1),result(N));
end generate;
---------------------------------------------

Cout <=  carry(bitwidth);

end RTL;
