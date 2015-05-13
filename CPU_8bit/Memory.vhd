library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity Mem is 
  generic (BitWidth: integer);
  port ( RdAddress: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
			WrtAddress: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         RW: in std_logic;
         rst: in std_logic;
         Data_Out: out std_logic_vector (BitWidth-1 downto 0) 
    );
end Mem;

architecture beh of Mem is

  type Mem_type is array (0 to (2**BitWidth)-1) of std_logic_vector(BitWidth-1 downto 0);
   signal Mem : Mem_type;
   
begin
  
 MemProcess: process(clk,rst) is

  begin
    if rst = '1' then 
      Mem<= ((others=> (others=>'0')));
    elsif rising_edge(clk) then
      if RW = '1' then
        Mem(to_integer(unsigned(WrtAddress(7 downto 0)))) <= Data_in;
      end if;
  
    end if;
  end process MemProcess;

  Data_Out <= Mem(to_integer(unsigned(RdAddress(7 downto 0))));
  
end beh;