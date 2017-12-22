--Copyright (C) 2017 Siavoosh Payandeh Azad

-- DPU has one fixed input which is coming directly from Register-File
-- The other input is selectable between Rfile, Memory, Control

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_misc.all;
use IEEE.Numeric_Std.all;
use work.pico_cpu.all;

--DPU entity
entity DPU is
  generic (BitWidth: integer);
  port (
         rst: in std_logic;
         clk: in std_logic;

         Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
         Data_in_RegFile_1: in std_logic_vector (BitWidth-1 downto 0);
         Data_in_RegFile_2: in std_logic_vector (BitWidth-1 downto 0);
         Data_in_control_2: in std_logic_vector (BitWidth-1 downto 0);

         ALUCommand: in ALU_COMMAND;
         Mux_Cont_2: in DPU_IN_MUX;

         DPU_OV      : out std_logic;
         Result      : out std_logic_vector (2*BitWidth-1 downto 0);
         Result_ACC  : out std_logic_vector (2*BitWidth-1 downto 0)
    );
end DPU;

--Architecture of the DPU
architecture RTL of DPU is

---------------------------------------------
--      Signals
---------------------------------------------
  signal ACC_in, ACC_out: std_logic_vector (2*BitWidth-1 downto 0);
  signal Mux_Out_1, Mux_Out_2: std_logic_vector (BitWidth-1 downto 0):= (others=>'0');

  ---------------------------------------------
  --      Flags
  ---------------------------------------------
  signal OV_Flag_Value, Cout :std_logic := '0';


begin

ALU_comp: ALU
          generic map (BitWidth => BitWidth)
          port map (Mux_Out_1, Mux_Out_2, ALUCommand, OV_Flag_Value, Cout, ACC_in);

  ---------------------------------------------
  --  Registers and Flags
  ---------------------------------------------
  CLOCK_PROCESS:process (clk,rst)
    begin
    if rst = '1' then
      ACC_out<=(others =>'0');
    elsif clk'event and clk= '1' then
      if ALUCommand = ALU_MULT or ALUCommand = ALU_MULTU or ALUCommand = ALU_MTHI or
         ALUCommand = ALU_MTLO or ALUCommand = ALU_DIV or ALUCommand = ALU_DIVU then
        ACC_out <= ACC_in;
      elsif ALUCommand = ALU_MADD then
        ACC_out <= std_logic_vector(signed(ACC_in) + signed(ACC_out));
      elsif ALUCommand = ALU_MADDU then
        ACC_out <= std_logic_vector(unsigned(ACC_in) + unsigned(ACC_out));
      elsif ALUCommand = ALU_MSUB then
        ACC_out <= std_logic_vector(signed(ACC_in) - signed(ACC_out));
      elsif ALUCommand = ALU_MSUBU then
        ACC_out <= std_logic_vector(unsigned(ACC_in) - unsigned(ACC_out));
      end if;
  end if;
  end process;

  ---------------------------------------------
  --    ALU Input multiplexer
  ---------------------------------------------
  Mux_Out_1 <= Data_in_RegFile_1;


  INPUT_MUX_2:process (Data_in_mem, Data_in_control_2, Data_in_RegFile_2, Mux_Cont_2)
    begin
      case Mux_Cont_2 is
        when MEM   => Mux_Out_2 <= Data_in_mem;
        when CONT  => Mux_Out_2 <= Data_in_control_2;
        when RFILE => Mux_Out_2 <= Data_in_RegFile_2;
        when ONE   => Mux_Out_2 <= std_logic_vector(to_unsigned(1, BitWidth));
      when others => Mux_Out_2 <= std_logic_vector(to_unsigned(0, BitWidth));
      end case;
  end process;



  Result <= ACC_in;
  Result_ACC <= ACC_out;
  DPU_OV <= OV_Flag_Value;

end RTL;
