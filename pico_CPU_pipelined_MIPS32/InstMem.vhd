
library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

entity InstMem is
  generic (BitWidth: integer;
           InstructionWidth: integer);
  port ( address : in std_logic_vector(BitWidth-1 downto 0);
         data : out std_logic_vector(InstructionWidth-1 downto 0) );
end entity InstMem;

architecture behavioral of InstMem is

  type mem is array ( 0 to InstMem_depth-1) of std_logic_vector(InstructionWidth-1 downto 0);

  constant my_InstMem : mem := (
  0  =>   "00100000000000010000000000011011", -- ADDI 0, 1, 27
  1  =>   "00000000000000010000000000100000", -- ADDU  1, 0, 0
  2  =>   "00100100010000111000000000011011", -- ADDIU  2, 3, 27
  3  =>   "00000000000000100000000000100100", -- AND_inst 0, 2, 0
  4  =>   "00110000011000100000000000010001", -- ANDI  2, 3, 17
  5  =>   "00000000000000100000000000100101", -- OR_inst 0, 2, 0
  6  =>   "00110100010000100000000000000100", -- ORI  2, 2, 4
  7  =>   "00000000000000100000000000100110", -- XOR_inst 0, 2, 0
  8  =>   "00111000010000100000000000000100", -- XORI  2, 2, 4
  9  =>   "00000000000000100000000000100111", -- NOR_inst 0, 2, 0
  10  =>  "00111100000001000000000000000100", -- LUI 0, 4, 4
others => "00000000000000000000000000000000"
    );


begin
  process(address)begin
    if to_integer(unsigned(address)) <= InstMem_depth-1 then
      data <= my_InstMem(to_integer(unsigned(address)));
    else
      data <= (others => '0');
    end if;
  end process;
end architecture behavioral;
