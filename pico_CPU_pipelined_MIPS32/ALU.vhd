library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
use work.pico_cpu.all;

--ALU entity
entity ALU is
  generic (BitWidth: integer);
  port ( A: in std_logic_vector (BitWidth-1 downto 0);
         B: in std_logic_vector (BitWidth-1 downto 0);
         Command: in ALU_COMMAND;
         OV_out: out std_logic;
         Cflag_out: out std_logic;
         Result: out std_logic_vector (2*BitWidth-1 downto 0)
    );
end ALU;

--Architecture of the DPU
architecture RTL of ALU is
---------------------------------------------
--      Signals
---------------------------------------------
 signal Cout: std_logic := '0';

begin


---------------------------------------------
Cflag_out <= Cout;


PROC_ALU: process(Command,A,B)
   variable temp : integer := 0;
   variable result_tmp : std_logic_vector(BitWidth downto 0);
   begin
    Result <= (others => '0');
    OV_out <= '0';
     case Command is
            WHEN ALU_ADDU    =>  result_tmp := std_logic_vector(unsigned('0'& A) + unsigned('0'& B)); --add
                                 Result(BitWidth-1 downto 0) <= result_tmp(BitWidth-1 downto 0);
                                 COUT <= result_tmp(BitWidth);
            WHEN ALU_SUBU    =>  result_tmp := std_logic_vector(unsigned('0'& A) - unsigned('0'& B)); --subtract
                                 Result(BitWidth-1 downto 0) <= result_tmp(BitWidth-1 downto 0);
                                 COUT <= result_tmp(BitWidth);
            WHEN ALU_ADD     =>  result_tmp := std_logic_vector(signed(A(BitWidth-1) & A) + signed(B(BitWidth-1) & B)); --add
                                Result(BitWidth-1 downto 0) <= result_tmp(BitWidth-1 downto 0);
                                COUT <= result_tmp(BitWidth);
                                if result_tmp(BitWidth) /= result_tmp(BitWidth-1) then
                                    OV_out <= '1';
                                end if;
            WHEN ALU_SUB     =>  result_tmp := std_logic_vector(signed(A(BitWidth-1) & A) - signed(B(BitWidth-1) & B)); --subtract
                                Result(BitWidth-1 downto 0) <= result_tmp(BitWidth-1 downto 0);
                                COUT <= result_tmp(BitWidth);
                                if result_tmp(BitWidth) /= result_tmp(BitWidth-1) then
                                    OV_out <= '1';
                                end if;
            WHEN ALU_PASS_A =>   Result(BitWidth-1 downto 0) <= A;  --Bypass A
            WHEN ALU_PASS_B =>   Result(BitWidth-1 downto 0) <= B;  --Bypass B
            WHEN ALU_MTLO   =>   Result(BitWidth-1 downto 0) <= A;  --Bypass A
            WHEN ALU_MTHI   =>   Result(BitWidth-1 downto 0) <= std_logic_vector(shift_left(unsigned(A), 16));  --Bypass B
            WHEN ALU_AND    =>   Result(BitWidth-1 downto 0) <= A and B;  --And
            WHEN ALU_OR     =>   Result(BitWidth-1 downto 0) <= A or B;  --or
            WHEN ALU_NOR    =>   Result(BitWidth-1 downto 0) <= not(A or B);  --or
            WHEN ALU_XOR    =>   Result(BitWidth-1 downto 0) <= A xor B;  --xor
            WHEN ALU_SLR    =>   Result(BitWidth-1 downto 0) <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(4 downto 0)))));--shift Rigth
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_SLL    =>   Result(BitWidth-1 downto 0) <= std_logic_vector(shift_left (unsigned(A), to_integer(unsigned(B(4 downto 0)))));--shift left
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_NEG_A  =>   Result(BitWidth-1 downto 0) <= not A +1;  --negation
            WHEN ALU_SAR    =>   Result(BitWidth-1 downto 0) <= A(BitWidth-1) & std_logic_vector(shift_right(unsigned(A(BitWidth-2 downto 0)), to_integer(unsigned(B(4 downto 0)))-1));  --shift right Arith
            WHEN ALU_SAL    =>   Result(BitWidth-1 downto 0) <= A(BitWidth-1) & std_logic_vector(shift_left(unsigned(A(BitWidth-2 downto 0)), to_integer(unsigned(B(4 downto 0)))-1));  --shift left Arith
            WHEN ALU_FLIP_A =>   Result(BitWidth-1 downto 0) <= not(A); --Not of A
            WHEN ALU_CLR_A  =>   Result(BitWidth-1 downto 0) <= (others => '0'); --Clear ACC
            WHEN ALU_MULTU  =>   Result <= A*B ; -- RLC
            WHEN ALU_MULT   =>   Result <= std_logic_vector(signed(A)*signed(B)) ; -- RLC
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_EQ     =>   if A = B then
                                    Result <= (others => '1');
                                 else
                                    Result <= (others => '0');
                                 end if;

            WHEN ALU_COMP_EQ=>   if A >= B then
                                     Result <= (others => '1');
                                  else
                                     Result <= (others => '0');
                                  end if;
                                  
            WHEN ALU_COMP   =>   if A > B then
                                   Result <= (others => '1');
                                 else
                                   Result <= (others => '0');
                                 end if;
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_CLO    =>  temp := 0;
                                for i in A'range loop
                                   if A(i) = '0' then
                                     temp := temp + 1;
                                   end if;
                                end loop;
                                Result(BitWidth-1 downto 0) <=  std_logic_vector(to_unsigned(temp,BitWidth));
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_CLZ    =>  temp := 0;
                                for i in A'range loop
                                  if A(i) = '1' then
                                    temp := temp + 1;
                                  end if;
                                end loop;
                                Result(BitWidth-1 downto 0) <=  std_logic_vector(to_unsigned(temp, BitWidth));
            -------------------------------------------------------------------------------------------------------------------------------------
       WHEN OTHERS => Result<= (others => '0');
    END CASE;

 end process PROC_ALU;

end RTL;
