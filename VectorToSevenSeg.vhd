library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 USE ieee.std_logic_unsigned.ALL; 
 USE IEEE.NUMERIC_STD.ALL;
 
entity VectorToSevenSeg is
port( clk: 			in std_logic;
		InputVector:in  std_logic_vector (15 downto 0);
		AN: 			out std_logic_vector(3 downto 0);
		SevenSeg: 	out std_logic_vector(6 downto 0)
);
end VectorToSevenSeg;

architecture Behavioral of VectorToSevenSeg is
signal counter: std_logic_vector(19 downto 0);
signal SvSegIn: std_logic_vector(3 downto 0);
signal bcd_hun :  std_logic_vector (3 downto 0) ;
signal bcd_ten :  std_logic_vector (3 downto 0) ;
signal bcd_uni :  std_logic_vector (3 downto 0)  ;
begin

process(clk)begin
 if clk'event and clk='1' then 
	counter <= counter + 1;
 end if;
end process;

process ( InputVector )
    variable hex_src : std_logic_vector (4 downto 0) ;
    variable bcd     : std_logic_vector (11 downto 0) ;
begin
    bcd             := (others => '0') ;
    bcd(2 downto 0) := '0'&InputVector(6 downto 5) ;
    hex_src         := InputVector(4 downto 0) ;

    for i in hex_src'range loop
        if bcd(3 downto 0) > "0100" then
            bcd(3 downto 0) := bcd(3 downto 0) + "0011" ;
        end if ;
        if bcd(7 downto 4) > "0100" then
            bcd(7 downto 4) := bcd(7 downto 4) + "0011" ;
        end if ;
        bcd := bcd(10 downto 0) & hex_src(hex_src'left) ; 
        hex_src := hex_src(hex_src'left - 1 downto hex_src'right) & '0' ;  
    end loop ;

    bcd_hun <= bcd(11 downto 8) ;
    bcd_ten <= bcd(7  downto 4) ;
    bcd_uni <= bcd(3  downto 0) ;
end process ;

process(bcd_hun,bcd_ten,bcd_uni,counter,InputVector(7))begin
 if counter(19 downto 18)="00" then 
	AN<="1110";	SvSegIn<= bcd_uni;
  elsif counter(19 downto 18)="01" then 
	AN<="1101"; SvSegIn<= bcd_ten;
  elsif counter(19 downto 18)="10" then 
	AN<="1011";	SvSegIn<= bcd_hun;
  elsif counter(19 downto 18)="11" then 
		if InputVector(7)='1' then 
			AN <="0111"; SvSegIn<= "1101";
		else
			AN <="0111"; SvSegIn<= "1111";
		end if;
 else
	AN <="1111"; SvSegIn<= "1111";
 end if;
end process;

process(SvSegIn)begin
 case SvSegIn is 			  --abcdefg
	when "0000"=> SevenSeg<="0000001";
	when "0001"=> SevenSeg<="1001111";
	when "0010"=> SevenSeg<="0010010";
	when "0011"=> SevenSeg<="0000110";
	when "0100"=> SevenSeg<="1001100";
	when "0101"=> SevenSeg<="0100100";
	when "0110"=> SevenSeg<="0100000";
	when "0111"=> SevenSeg<="0001111";
	when "1000"=> SevenSeg<="0000000";
	when "1001"=> SevenSeg<="0000100";
	when "1101"=> SevenSeg<="1111110";
	when others => SevenSeg<="1111111";
	end case;
end process;
end Behavioral;

