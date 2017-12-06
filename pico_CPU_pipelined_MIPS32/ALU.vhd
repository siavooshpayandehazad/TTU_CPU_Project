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
         Cflag_in: in std_logic;
         Cflag_out: out std_logic;
         Result: out std_logic_vector (2*BitWidth-1 downto 0)
    );
end ALU;

--Architecture of the DPU
architecture RTL of ALU is
---------------------------------------------
--      Signals
---------------------------------------------
 signal AddSub_result: std_logic_vector (BitWidth-1 downto 0) := (others => '0');
 signal Cout,Add_Sub: std_logic := '0';

begin
---------------------------------------------
--      component instantiation
---------------------------------------------
Adder_comp: Adder_Sub generic map (BitWidth => BitWidth)  port map (A,B,Add_Sub,AddSub_result,Cout);
---------------------------------------------
Cflag_out <= Cout;


PROC_ALU: process(Command,A,B,AddSub_result,Cflag_in)
   variable temp : integer := 0;
   begin
    Add_Sub <= '0';  
    Result <= (others => '0');
     case Command is
            WHEN ALU_ADD    =>   Result(BitWidth-1 downto 0) <= AddSub_result; --add
            WHEN ALU_SUB    =>   Add_Sub <= '1';
                                 Result(BitWidth-1 downto 0) <= AddSub_result; -- Subtract
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
            WHEN ALU_SAR    =>   Result(BitWidth-1 downto 0) <= A(BitWidth-1) & A(BitWidth-1 downto 1) ;  --shift right Arith
            WHEN ALU_SAL    =>   Result(BitWidth-1 downto 0) <= A(BitWidth-1) & A(BitWidth-3 downto 0)& A(0) ;  --shift left Arith
            WHEN ALU_FLIP_A =>   Result(BitWidth-1 downto 0) <= not(A); --Not of A
            WHEN ALU_CLR_A  =>   Result(BitWidth-1 downto 0) <= (others => '0'); --Clear ACC
            WHEN ALU_RRC    =>   Result(BitWidth-1 downto 0) <= Cflag_in & A(BitWidth-1 downto 1); -- RRC
            WHEN ALU_RLC    =>   Result(BitWidth-1 downto 0) <= A(BitWidth-2 downto 0)& Cflag_in ; -- RLC
            WHEN ALU_MULTU  =>   Result <= A*B ; -- RLC
            WHEN ALU_MULT  =>   Result <= std_logic_vector(signed(A)*signed(B)) ; -- RLC
            -------------------------------------------------------------------------------------------------------------------------------------
            WHEN ALU_COMP   =>   if A = B then
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
