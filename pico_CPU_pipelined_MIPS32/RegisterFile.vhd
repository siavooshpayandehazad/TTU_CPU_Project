
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity RegisterFile is
generic (BitWidth: integer);
  port ( clk : in std_logic;
			rst: in std_logic;
			Data_in_mem        : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_CU         : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_DPU_LOW    : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_DPU_HI     : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_ACC_LOW    : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_ACC_HI     : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_R2         : in std_logic_vector (BitWidth-1 downto 0);
			Data_in_sel        : in RFILE_IN_MUX;
			RFILE_in_address   : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
			WB_enable          : in std_logic_vector (3 downto 0);
			Register_out_sel_1 : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
			Register_out_sel_2 : in std_logic_vector (RFILE_SEL_WIDTH-1 downto 0);
			Data_out_1         : out std_logic_vector (BitWidth-1 downto 0);
			Data_out_2         : out std_logic_vector (BitWidth-1 downto 0)
  );
end RegisterFile;

architecture Behavioral of RegisterFile is
type RFILE_type is array (0 to RFILE_DEPTH-1) of std_logic_vector(BitWidth-1 downto 0) ;
   signal RFILE : RFILE_type := ((others=> (others=>'0')));

signal Data_in: std_logic_vector (BitWidth-1 downto 0):= (others=>'0');

alias address_in : std_logic_vector(RFILE_SEL_WIDTH-1 downto 0) is RFILE_in_address(RFILE_SEL_WIDTH-1 downto 0);
begin

  process (clk,rst)begin
  	if rst = '1' then
  		RFILE <= ((others=> (others=>'0')));
  	elsif clk'event and clk='1' then
      if WB_enable(0) = '1' then
  		    RFILE(to_integer(unsigned(RFILE_in_address)))(7 downto 0) <= Data_in(7 downto 0);
      elsif WB_enable(1) = '1' then
          RFILE(to_integer(unsigned(RFILE_in_address)))(15 downto 8) <= Data_in(15 downto 8);
      elsif WB_enable(2) = '1' then
          RFILE(to_integer(unsigned(RFILE_in_address)))(23 downto 16) <= Data_in(23 downto 16);
      elsif WB_enable(3) = '1' then
          RFILE(to_integer(unsigned(RFILE_in_address)))(31 downto 23) <= Data_in(31 downto 23);
      end if;
       RFILE(0) <= (others=>'0');
  	end if;
  end process;


  process(Data_in_mem,Data_in_CU,Data_in_ACC_HI, Data_in_ACC_LOW, Data_in_DPU_LOW, Data_in_DPU_HI,Data_in_sel)begin
   case Data_in_sel is
  	when CU                => Data_in <= Data_in_CU;
    when DPU_LOW           => Data_in <= Data_in_DPU_LOW;
  	when DPU_HI            => Data_in <= Data_in_DPU_HI;
    when ACC_LOW           => Data_in <= Data_in_ACC_LOW;
  	when ACC_HI            => Data_in <= Data_in_ACC_HI;
  	when R2                => Data_in <= Data_in_R2;
  	when FROM_MEM8         => Data_in  <= ZERO16 & ZERO8 & Data_in_mem(7 downto 0);
  	when FROM_MEM16        => Data_in  <= ZERO16 & Data_in_mem(15 downto 0);
    when FROM_MEM8_SGINED  =>
                               if Data_in_mem(7) = '0' then
                                    Data_in  <= ZERO16 & ZERO8 & Data_in_mem(7 downto 0);
                               else
                                    Data_in  <= ONE16 & ONE8 & Data_in_mem(7 downto 0);
                               end if;
    when FROM_MEM16_SGINED  =>
                               if Data_in_mem(15) = '0' then
                                    Data_in  <= ZERO16 & Data_in_mem(15 downto 0);
                               else
                                    Data_in  <= ONE16 & Data_in_mem(15 downto 0);
                               end if;
  	when FROM_MEM32         => Data_in <= Data_in_mem;
  	when others => Data_in <= (others=>'0');
   end case;
  end process;

  process(Register_out_sel_1, address_in, Data_in, Data_in_sel)begin
    if address_in = Register_out_sel_1 and (Data_in_sel = FROM_MEM8 or Data_in_sel = FROM_MEM16 or Data_in_sel = FROM_MEM32) then
      Data_out_1 <= Data_in;
    else
      Data_out_1<= RFILE(to_integer(unsigned(Register_out_sel_1)));
    end if;
  end process;

  process(Register_out_sel_2, address_in, Data_in, Data_in_sel)begin
    if address_in = Register_out_sel_2 and (Data_in_sel = FROM_MEM8 or Data_in_sel = FROM_MEM16 or Data_in_sel = FROM_MEM32) then
      Data_out_2 <= Data_in;
    else
      Data_out_2<= RFILE(to_integer(unsigned(Register_out_sel_2)));
    end if;
  end process;

end Behavioral;
