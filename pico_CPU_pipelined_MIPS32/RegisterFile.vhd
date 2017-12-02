
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity RegisterFile is
generic (BitWidth: integer);
  port ( clk : in std_logic;
			rst: in std_logic;
			Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_CU: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_ACC: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_sel: in std_logic_vector (1 downto 0);
			Register_in_sel: in std_logic_vector (RFILE_SEL_WIDTH downto 0);
			Register_out_sel_1: in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
			Register_out_sel_2: in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
			Data_out_1: out std_logic_vector (BitWidth-1 downto 0);
			Data_out_2: out std_logic_vector (BitWidth-1 downto 0)
  );
end RegisterFile;

architecture Behavioral of RegisterFile is
type RFILE_type is array (0 to RFILE_DEPTH-1) of std_logic_vector(BitWidth-1 downto 0) ;
   signal RFILE : RFILE_type := ((others=> (others=>'0')));

signal Data_in: std_logic_vector (BitWidth-1 downto 0):= (others=>'0');

alias address_in : std_logic_vector(RFILE_SEL_WIDTH-1 downto 0) is Register_in_sel(RFILE_SEL_WIDTH-1 downto 0);
begin

  process (clk,rst)begin
  	if rst = '1' then
  		RFILE <= ((others=> (others=>'0')));
  	elsif clk'event and clk='1' then
      if Register_in_sel(RFILE_SEL_WIDTH) = '1' then
  		    RFILE(to_integer(unsigned(address_in))) <= Data_in;
      end if;
  	end if;
  end process;


  process(Data_in_mem,Data_in_CU,Data_in_ACC,Data_in_sel)begin
   case Data_in_sel is
  	when "01" => Data_in <= Data_in_CU;
  	when "10" => Data_in <= Data_in_ACC;
  	when "11" => Data_in <= Data_in_mem;
  	when others => Data_in <= (others=>'0');
   end case;
  end process;

  process(Register_out_sel_1, address_in, Data_in)begin
    if address_in = Register_out_sel_1 then
      Data_out_1 <= Data_in;
    else
      Data_out_1<= RFILE(to_integer(unsigned(Register_out_sel_1)));
    end if;
  end process;

  process(Register_out_sel_2, address_in, Data_in)begin
    if address_in = Register_out_sel_2 then
      Data_out_2 <= Data_in;
    else
      Data_out_2<= RFILE(to_integer(unsigned(Register_out_sel_2)));
    end if;
  end process;

end Behavioral;
