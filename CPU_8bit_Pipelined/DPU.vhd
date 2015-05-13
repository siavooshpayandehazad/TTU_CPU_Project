library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_misc.all; 
use IEEE.Numeric_Std.all;
--DPU entity
entity DPU is
  generic (BitWidth: integer);
  port ( Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
         Data_in: in std_logic_vector (BitWidth-1 downto 0);
         clk: in std_logic;
         Command: in std_logic_vector (10 downto 0);
			Reg_in_sel: in std_logic_vector (7 downto 0);
			Reg_out_sel: in std_logic_vector (2 downto 0); 
         rst: in std_logic;
         DPU_Flags: out std_logic_vector (3 downto 0);
         Result: out std_logic_vector (BitWidth-1 downto 0) 
    );
end DPU;

--Architecture of the DPU
architecture RTL of DPU is

---------------------------------------------
--      component declaration
---------------------------------------------
 component ALU is
   generic (BitWidth: integer);  
 port ( A: in std_logic_vector (BitWidth-1 downto 0);
        B: in std_logic_vector (BitWidth-1 downto 0);
        Command: in std_logic_vector (3 downto 0);
        Cflag_in: in std_logic;
        Cflag_out: out std_logic;
        Result: out std_logic_vector (BitWidth-1 downto 0)
  );
  end component;
  
 component RegisterFile is
	generic (BitWidth: integer);
  port ( clk : in std_logic;
			rst: in std_logic;
			Data_in_mem: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_CU: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_ACC: in std_logic_vector (BitWidth-1 downto 0);
			Data_in_sel: in std_logic_vector (1 downto 0);
			Register_in_sel: in std_logic_vector (7 downto 0);
			Register_out_sel: in std_logic_vector (2 downto 0);
			Data_out: out std_logic_vector (BitWidth-1 downto 0)
  );
 end component;

---------------------------------------------
--      Signals
---------------------------------------------
  signal ACC_in,ACC_out: std_logic_vector (BitWidth-1 downto 0);
  signal Reg_out: std_logic_vector (BitWidth-1 downto 0); 
  signal Mux_Out: std_logic_vector (BitWidth-1 downto 0);
 
  ---------------------------------------------
  --      Flags
  ---------------------------------------------
  signal EQ_Flag_out,EQ_Flag_in: std_logic;
  signal OV_Flag_out,OV_Flag_in: std_logic;
  signal Z_Flag_out,Z_Flag_in: std_logic;
  signal C_flag_in,C_flag_out,Cout:std_logic;
  signal OV_Flag_Value,Z_Flag_Value:std_logic;
  ---------------------------------------------
  --        Opcode Aliases
  ---------------------------------------------  
  alias Mux_Cont : std_logic_vector (1 downto 0) is Command (1 downto 0);
  alias ALUCommand : std_logic_vector (3 downto 0) is Command (5 downto 2);
  alias SetFlag : std_logic_vector (2 downto 0) is Command (8 downto 6);
  alias B_Mux_Cont : std_logic_vector (1 downto 0) is Command (10 downto 9);
  
begin
 
ALU_comp: ALU generic map (BitWidth => BitWidth)  port map (ACC_out, Mux_Out, ALUCommand,C_flag_out,Cout,ACC_in);
RegFile_comp: RegisterFile generic map (BitWidth => BitWidth)  port map (clk, rst,Data_in_mem,Data_in,ACC_out,B_Mux_Cont,Reg_in_sel,Reg_out_sel,Reg_out);
  
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
    elsif clk'event and clk='1' then
      ACC_out<=ACC_in;
 
      OV_Flag_out <= OV_Flag_in;
      Z_Flag_out <= Z_Flag_in;
      EQ_Flag_out <= EQ_Flag_in; 
      C_flag_out <= C_flag_in;
  end if; 
  end process;
  
  ---------------------------------------------
  --    ALU 2nd Input multiplexer
  ---------------------------------------------
  process (Data_in_mem,Data_in,Reg_out,Mux_Cont)
    begin
      case Mux_Cont is 
        when "00" => Mux_Out <= Data_in_mem;
        when "01" => Mux_Out <= Data_in;
        when "10" => Mux_Out <= Reg_out;   
        when "11" => Mux_Out <= std_logic_vector(to_unsigned(1, BitWidth ));    
      when others => Mux_Out <= std_logic_vector(to_unsigned(0, BitWidth ));    
      end case;
  end process;

  
  OV_Flag_Value <= (ACC_in(BitWidth-1 ) and Mux_Out(BitWidth-1 ) and (not ACC_out(BitWidth-1 ))) or ((not ACC_in(BitWidth-1 )) and (not Mux_Out(BitWidth-1)) and ACC_out(BitWidth-1));
  Z_Flag_Value <= not (or_reduce(ACC_in));
  ---------------------------------------------
  --  Flag controls
  ---------------------------------------------
 
  process(SetFlag,ALUCommand,Z_Flag_Value,OV_Flag_Value,Data_in,Cout,ACC_out(0),ACC_out(BitWidth-1),EQ_Flag_out,
				Z_Flag_out,C_flag_out,OV_Flag_out)
    begin 
  
      ----------------------------------
        if SetFlag = "011" then
              EQ_Flag_in <= '0';  
        else
          if ALUCommand /= "0010" then
              if (ACC_out = Data_in) then
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
          Z_Flag_in <= Z_Flag_Value;
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
  
  Result <= ACC_out;
  DPU_Flags <= C_flag_out & EQ_Flag_out & Z_Flag_out  & OV_Flag_out;
  
end RTL;
