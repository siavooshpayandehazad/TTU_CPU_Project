library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity Memory is
  generic (BitWidth: integer);
  port ( RdAddress: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
			   WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         RW: in std_logic_vector(3 downto 0);
         rst: in std_logic;
         Data_Out: out std_logic_vector (BitWidth-1 downto 0)
    );
end Memory;

architecture beh of Memory is

  type Mem_type is array (0 to DataMem_depth-1) of std_logic_vector(BitWidth-1 downto 0) ;
   signal Mem : Mem_type := ((others=> (others=>'0')));
   signal read_enable : std_logic;
begin

  read_enable <= RW(0) or RW(1) or RW(2) or RW(3);


 MemProcess: process(clk,rst) is
  begin
    if rst = '1' then
      Mem<= ((others=> (others=>'0')));
    elsif rising_edge(clk) then
      if read_enable = '1' then
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
  end process MemProcess;

  process(RdAddress,clk)begin
   if rising_edge(clk) then
      if to_integer(unsigned(RdAddress(BitWidth-1 downto 0))) <= DataMem_depth-1 then
        Data_Out <= Mem(to_integer(unsigned(RdAddress(BitWidth-1 downto 0))));
      else
        Data_Out <= (others=> '0');
      end if;
   end if;
  end process;

end beh;
