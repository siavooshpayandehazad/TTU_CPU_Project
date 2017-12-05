
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
  4  =>   "00000000000000100000000000100100", -- AND_inst 0, 2, 0
  5  =>   "00110000011000100000000000010001", -- ANDI  2, 3, 17
  6  =>   "00000000000000100000000000100101", -- OR_inst 0, 2, 0
  7  =>   "00110100010000100000000000000100", -- ORI  2, 2, 4
  8  =>   "00000000000000100000000000100110", -- XOR_inst 0, 2, 0
  9  =>   "00111000010000100000000000000100", -- XORI  2, 2, 4
  --10  =>  "00000000000000000001000010000000",  -- SLL
  --10  =>  "00000000000000000001000010000010",  -- SRL
  10  =>  "00000000000000100001000000000100",  -- SLLV
  --10  =>  "00000000000000100001000000000110",  -- SRLV
  --11  =>  "01110000000000000000000000100001", -- CLO
  11  =>  "01110000000000000000000000100000", -- CLZ
  12  =>  "00000000000000100000000000100111", -- NOR_inst 0, 2, 0
  --12  =>  "00000000000000100000000000011000", -- MULT  0, 2
  13  =>  "01110000001000100011100000000010", -- MUL  7, 0, 2
  14  =>  "00111100000001000000000000000100", -- LUI 0, 4, 4
  15  =>  "00000000100000100000000000100011", -- SUBU 0, 4, 2
  16  =>  "00000000001000100000000000011001", -- MULTU 1, 2
  17  =>  "00010000001000000000000000000111", -- BEQ 3
  --12  =>  "00001000000000000000000000000001", -- J 4
  --12  =>  "00000001111000000000000000001000", -- JR 4
  18  =>  "00000000100000100000000000100011", -- SUBU 0, 4, 2
  19  =>  "00000000100000100000000000100011", -- SUBU 0, 4, 2
  20  =>  "00000000100000100000000000100011", -- SUBU 0, 4, 2
  21  =>  "00000000100000100000000000100011", -- SUBU 0, 4, 2
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
