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
         Data_in_control_1: in std_logic_vector (BitWidth-1 downto 0);
         Data_in_control_2: in std_logic_vector (BitWidth-1 downto 0);

         ALUCommand: in std_logic_vector (ALU_COMAND_WIDTH-1 downto 0);
         Mux_Cont_1: in std_logic_vector (1 downto 0);
         Mux_Cont_2: in std_logic_vector (1 downto 0);
         SetFlag   : in std_logic_vector (2 downto 0);

         DPU_Flags   : out std_logic_vector (3 downto 0);
         DPU_Flags_FF: out std_logic_vector (3 downto 0);
         Result      : out std_logic_vector (2*BitWidth-1 downto 0);
         Result_FF   : out std_logic_vector (2*BitWidth-1 downto 0)
    );
end DPU;

--Architecture of the DPU
architecture RTL of DPU is

---------------------------------------------
--      Signals
---------------------------------------------
  signal ACC_in,ACC_out: std_logic_vector (2*BitWidth-1 downto 0);
  signal Mux_Out_1, Mux_Out_2: std_logic_vector (BitWidth-1 downto 0):= (others=>'0');

  ---------------------------------------------
  --      Flags
  ---------------------------------------------
  signal EQ_Flag_out, EQ_Flag_in: std_logic := '0';
  signal OV_Flag_out, OV_Flag_in: std_logic := '0';
  signal Z_Flag_out, Z_Flag_in: std_logic := '0';
  signal C_flag_in, C_flag_out, Cout:std_logic := '0';
  signal OV_Flag_Value :std_logic := '0';


begin

ALU_comp: ALU
generic map (BitWidth => BitWidth)
port map (Mux_Out_1, Mux_Out_2, ALUCommand, C_flag_out, Cout, ACC_in);

  ---------------------------------------------
  --  Registers and Flags
  ---------------------------------------------
  process (clk,rst)
    begin
    if rst = '1' then
      ACC_out<=(others =>'0');
      OV_Flag_out <= '0';
      Z_Flag_out <=  '0';
      EQ_Flag_out <=  '0';
      C_flag_out <= '0';
    elsif clk'event and clk= '1' then
      if ALUCommand = ALU_MULT or ALUCommand = ALU_MULTU then
        ACC_out <= ACC_in;
      end if;
      OV_Flag_out <= OV_Flag_in;
      Z_Flag_out <= Z_Flag_in;
      EQ_Flag_out <= EQ_Flag_in;
      C_flag_out <= C_flag_in;
  end if;
  end process;

  ---------------------------------------------
  --    ALU 2nd Input multiplexer
  ---------------------------------------------
  process (Data_in_mem, Data_in_control_1, Data_in_RegFile_1, Mux_Cont_1)
    begin
      case Mux_Cont_1 is
        when "00" => Mux_Out_1 <= Data_in_mem;
        when "01" => Mux_Out_1 <= Data_in_control_1;
        when "10" => Mux_Out_1 <= Data_in_RegFile_1;
        when "11" => Mux_Out_1 <= std_logic_vector(to_unsigned(1, BitWidth));
      when others => Mux_Out_1 <= std_logic_vector(to_unsigned(0, BitWidth));
      end case;
  end process;


  process (Data_in_mem, Data_in_control_2, Data_in_RegFile_2, Mux_Cont_2)
    begin
      case Mux_Cont_2 is
        when "00" => Mux_Out_2 <= Data_in_mem;
        when "01" => Mux_Out_2 <= Data_in_control_2;
        when "10" => Mux_Out_2 <= Data_in_RegFile_2;
        when "11" => Mux_Out_2 <= std_logic_vector(to_unsigned(1, BitWidth));
      when others => Mux_Out_2 <= std_logic_vector(to_unsigned(0, BitWidth));
      end case;
  end process;


  OV_Flag_Value <= (ACC_in(BitWidth-1 ) and Mux_Out_1(BitWidth-1 ) and (not Mux_Out_2(BitWidth-1 ))) or ((not ACC_in(BitWidth-1 )) and (not Mux_Out_1(BitWidth-1)) and Mux_Out_2(BitWidth-1));
  ---------------------------------------------
  --  Flag controls
  ---------------------------------------------

  process(SetFlag, ALUCommand, ACC_in, OV_Flag_Value, Data_in_control_1, Cout, ACC_out, EQ_Flag_out,
				Z_Flag_out, C_flag_out, OV_Flag_out)
    begin
      ----------------------------------
        if SetFlag = "011" then
              EQ_Flag_in <= '0';
        else
          if ALUCommand /= "0010" then
              if (ACC_out(BitWidth-1 downto 0) = Data_in_control_1) then
                  EQ_Flag_in <= '1';
               else
                  EQ_Flag_in <= '0';
              end if;
          else
              EQ_Flag_in <= EQ_Flag_out;
          end if;
        end if;
      ----------------------------------
      if SetFlag = "001" then
        Z_Flag_in <= '0';
      else
        if  ALUCommand /= "0010" then
          Z_Flag_in <=  not (or_reduce(ACC_in));
        else
          Z_Flag_in <= Z_Flag_out;
        end if;
      end if;
      ----------------------------------
      if SetFlag = "100" then
        C_flag_in <= '0';
      else
        if  ALUCommand /= "0010" and ALUCommand /= "1110" and ALUCommand /= "1111" then
          C_flag_in <= Cout;
        elsif  ALUCommand = "1110" then --RRC
           C_flag_in <= ACC_out(0);
        elsif  ALUCommand = "1111" then --RLC
          C_flag_in <= ACC_out(BitWidth-1);
        else
          C_flag_in <= C_flag_out;
        END IF;
      end if;
      ----------------------------------
      if SetFlag = "010" then
          OV_Flag_in <= '0';
      else
          if (ALUCommand = "0000" or ALUCommand = "0001") then
              OV_Flag_in <= OV_Flag_Value;
          else
              OV_Flag_in <= OV_Flag_out;
          end if;
       end if;
      ----------------------------------

  end process;

  Result <= ACC_in;
  Result_FF <= ACC_out;
  DPU_Flags <= C_flag_in & EQ_Flag_in & Z_Flag_in  & OV_Flag_in;
  DPU_Flags_FF <= C_flag_out & EQ_Flag_out & Z_Flag_out  & OV_Flag_out;

end RTL;
