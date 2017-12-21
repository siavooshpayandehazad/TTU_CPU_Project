--Copyright (C) 2017 Siavoosh Payandeh Azad

-- this is a dual port memory with 1 clock cycle delay
--           ___      ___      ___      ___      ___
--CLK   ____|   |____|   |____|   |____|   |____|   |___
--      ____ _________ ________________________________
--ADDR  ____X_ADDRESS_X________________________________
--      _____________ _________________________________
--DOUT  _____________X___DATA OUT______________________
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity RAM is
  generic (BitWidth: integer;
           preload_file: string :="code.txt");
  port ( RdAddress_1: in std_logic_vector (BitWidth-1 downto 0);
         RdAddress_2: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
			   WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         RW: in std_logic_vector(3 downto 0);
         rst: in std_logic;
         Data_Out_1: out std_logic_vector (BitWidth-1 downto 0);
         Data_Out_2: out std_logic_vector (BitWidth-1 downto 0)
    );
end RAM;

architecture beh of RAM is

  type Mem_type is array (0 to DataMem_depth-1) of std_logic_vector(BitWidth-1 downto 0) ;
   signal Mem : Mem_type := ((others=> (others=>'0')));
   signal write_enable : std_logic;


begin

  write_enable <= RW(0) or RW(1) or RW(2) or RW(3);
-------------------------------------------------------------------------------------------------
 MemProcess: process(clk,rst) is
   file preloadfile : text open read_mode is preload_file;
   variable address : integer := 0;
   variable line_read : line;
   variable line_data : std_logic_vector(31 downto 0);
  begin
    if rst = '1' then
        -- reading from file and load the momory
        -- remove the following lines for syntehsis
        address := 0;
        while not endfile(preloadfile) loop
              readline(preloadfile, line_read);
              hread(line_read, line_data);
              Mem(address) <= line_data;
              address := address + 1;
        end loop;
        -- For synthesis replace the above block with the following:
        --Mem<= ((others=> (others=>'0')));
    elsif rising_edge(clk) then
      if write_enable = '1' then
        if to_integer(unsigned(WrtAddress(BitWidth-1 downto 0))) <= DataMem_depth-1 then
          if RW(0) = '1' then
            Mem(to_integer(unsigned(WrtAddress(BitWidth-1 downto 0))))(7 downto 0) <= Data_in(7 downto 0);
          end if;
          if RW(1) = '1' then
            Mem(to_integer(unsigned(WrtAddress(BitWidth-1 downto 0))))(15 downto 8) <= Data_in(15 downto 8);
          end if;
          if RW(2) = '1' then
            Mem(to_integer(unsigned(WrtAddress(BitWidth-1 downto 0))))(23 downto 16) <= Data_in(23 downto 16);
          end if;
          if RW(3) = '1' then
            Mem(to_integer(unsigned(WrtAddress(BitWidth-1 downto 0))))(31 downto 24) <= Data_in(31 downto 24);
          end if;
        end if;
      end if;

    end if;
  end process;
-------------------------------------------------------------------------------------------------
  DATA_OUT_1_SEL:process(RdAddress_1,clk)begin
   if rising_edge(clk) then
      -- here we check if the address is in the momory could be removed if the memory depth is
      -- fixed
      if to_integer(unsigned(RdAddress_1(BitWidth-1 downto 0))) <= DataMem_depth-1 then
        Data_Out_1 <= Mem(to_integer(unsigned(RdAddress_1(BitWidth-1 downto 0))));
      else
        Data_Out_1 <= (others=> '0');
      end if;
   end if;
  end process;
-------------------------------------------------------------------------------------------------
  DATA_OUT_2_SEL:process(RdAddress_2,clk)begin
   if rising_edge(clk) then
      -- here we check if the address is in the momory could be removed if the memory depth is
      -- fixed
      if to_integer(unsigned(RdAddress_2(BitWidth-1 downto 0))) <= DataMem_depth-1 then
        Data_Out_2 <= Mem(to_integer(unsigned(RdAddress_2(BitWidth-1 downto 0))));
      else
        Data_Out_2 <= (others=> '0');
      end if;
   end if;
  end process;

end beh;
