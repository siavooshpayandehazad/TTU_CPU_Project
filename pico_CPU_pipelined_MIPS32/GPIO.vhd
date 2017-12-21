library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity GPIO is
  generic (BitWidth: integer);
  port ( IO_sel:  in    std_logic;
         IO: inout std_logic_vector (BitWidth-1 downto 0);
         WrtData: in    std_logic_vector (BitWidth-1 downto 0);
         RdData:  out   std_logic_vector (BitWidth-1 downto 0)
    );
end GPIO;



architecture behavioral of GPIO is
  begin
    IO_CONT:process(IO_sel, IO, WrtData)begin
        if IO_sel = '0' then
          IO <= (others => 'Z');
          RdData <= IO;
        else
          IO <= WrtData;
        end if;
    end process;
end behavioral;
