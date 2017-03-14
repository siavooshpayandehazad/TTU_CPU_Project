library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_unsigned.ALL; 

entity PicoCPU is
	port(
		rst			: in 	STD_LOGIC;
		clk			: in 	STD_LOGIC;
		SwitchIn 	: in 	STD_LOGIC_VECTOR (7 downto 0);
		update_mux 	: out 	STD_LOGIC;
		Mux 		: out 	STD_LOGIC_VECTOR (3 downto 0);
		NegPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
		PosPin 		: out 	STD_LOGIC_VECTOR (7 downto 0);
		FlagOut		: out 	STD_LOGIC_VECTOR (3 downto 0);
		output		: out 	STD_LOGIC_VECTOR (15 downto 0)
	);
end PicoCPU;


architecture RTL of PicoCPU is

---------------------------------------------
--      component declaration
---------------------------------------------

	component ControlUnit is
	generic (BitWidth: integer;
					 InstructionWidth:integer);  
		port(
			rst					: in 	STD_LOGIC;
			clk					: in 	STD_LOGIC;        
			Instr_In			: in 	STD_LOGIC_VECTOR (InstructionWidth-1 downto 0);
			Instr_Add			: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);       
			MemRdAddress		: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
			MemWrtAddress		: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
			Mem_RW				: out 	STD_LOGIC;  
			DPU_Flags			: in 	STD_LOGIC_VECTOR (3 downto 0);
			DataToDPU			: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
			CommandToDPU		: out 	STD_LOGIC_VECTOR (10 downto 0);
			Reg_in_sel			: out 	STD_LOGIC_VECTOR (7 downto 0);
			Reg_out_sel			: out 	STD_LOGIC_VECTOR (2 downto 0); 
			DataFromDPU			: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0)
		);
	end component;
	----------------------------------------
	-- 	Component written in VHDL	
--  component InstMem is
--    generic (BitWidth : integer;
--           InstructionWidth:integer); 
--    port ( address : in STD_LOGIC_VECTOR(BitWidth-1 downto 0);
--         data : out STD_LOGIC_VECTOR(InstructionWidth-1 downto 0) );
--  end component;
	----------------------------------------
 component instmemory is
	 generic (	BitWidth 		: integer;
				InstructionWidth: integer); 
	 port ( address 			: in 	STD_LOGIC_VECTOR(BitWidth-1 downto 0);
			data 				: out 	STD_LOGIC_VECTOR(InstructionWidth-1 downto 0) );
	end component;

	component DPU is
		generic (BitWidth: integer);
		port ( 	Data_in_mem		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
				Data_in			: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
				clk				: in 	STD_LOGIC;
				Command			: in 	STD_LOGIC_VECTOR (10 downto 0);
				Reg_in_sel		: in 	STD_LOGIC_VECTOR (7 downto 0);
				Reg_out_sel		: in 	STD_LOGIC_VECTOR (2 downto 0); 
				rst				: in 	STD_LOGIC;
				DPU_Flags		: out 	STD_LOGIC_VECTOR (3 downto 0);
				Result			: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0) 
	);
	end component;
	----------------------------------------
	component Mem is
		generic (BitWidth: integer);  
		port ( 
				clk				: in 	STD_LOGIC;
				rst 			: in 	STD_LOGIC;
				RW 				: in 	STD_LOGIC;
				RdAddress 		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
				Data_in 		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
				WrtAddress 		: in 	STD_LOGIC_VECTOR (BitWidth-1 downto 0);
				Tabloo_Addr   	: in  	STD_LOGIC_VECTOR (5 downto 0);
				data_ready    	: out   STD_LOGIC;  
				Tabloo_Data   	: out 	STD_LOGIC_VECTOR (7 downto 0);
				Data_Out 		: out 	STD_LOGIC_VECTOR (BitWidth-1 downto 0) 
		);
	end component;

	component Tabloo_driver is
		Port ( clk, rst 		: in  STD_LOGIC;
			Refresh_data		: in  STD_LOGIC;
			Tabloo_Mem_Data		: in  STD_LOGIC_VECTOR(7 downto 0);
			update_mux			: out STD_LOGIC;
			Tabloo_Mem_Addr		: out STD_LOGIC_VECTOR(5 downto 0);
			Tabloo_Mux			: out STD_LOGIC_VECTOR(3 downto 0);
			Tabloo_NegPin		: out STD_LOGIC_VECTOR(7 downto 0);
			Tabloo_PosPin		: out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
---------------------------------------------
--      constants
---------------------------------------------
constant CPU_Bitwidth : integer := 16;
constant CPU_Instwidth : integer := 6 + CPU_Bitwidth;

---------------------------------------------
--      Signals
---------------------------------------------
signal Instr		: STD_LOGIC_VECTOR (CPU_Instwidth-1 downto 0);
signal InstrAdd, Mem_Rd_Address, Mem_Wrt_Address, DPUData, MEMDATA, DPU_Result
					: STD_LOGIC_VECTOR (CPU_Bitwidth-1 downto 0) ;
signal MemRW		: STD_LOGIC;
signal DPUFlags		: STD_LOGIC_VECTOR (3 downto 0);
signal DPUCommand 	: STD_LOGIC_VECTOR (10 downto 0);
signal Reg_in_sel	: STD_LOGIC_VECTOR (7 downto 0);
signal Reg_out_sel	: STD_LOGIC_VECTOR (2 downto 0);

signal Tabloo_Data  : STD_LOGIC_VECTOR (7 downto 0);
signal Tabloo_Addr  : STD_LOGIC_VECTOR (5 downto 0);
signal data_ready  	: STD_LOGIC;

begin

---------------------------------------------
--      component instantiation
---------------------------------------------
	ControlUnit_comp: ControlUnit 
		generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
		port map (rst, clk, Instr ,InstrAdd , Mem_Rd_Address, Mem_Wrt_Address , MemRW, DPUFlags, DPUData,DPUCommand,Reg_in_sel,Reg_out_sel,DPU_Result);
	--instruction memory  
	InstMem_comp: instmemory
		generic map (BitWidth => CPU_Bitwidth, InstructionWidth => CPU_Instwidth)
		port map (InstrAdd,Instr);
	--datapath unit
	DPU_comp: DPU 
		generic map (BitWidth => CPU_Bitwidth)
		port map (MEMDATA, DPUData, clk,DPUCommand,Reg_in_sel,Reg_out_sel,rst,DPUFlags,DPU_Result);
	--memory
	Mem_comp: Mem 
		generic map (BitWidth => CPU_Bitwidth)
		port map ( clk => clk, rst => rst, RW => MemRW,
			RdAddress => Mem_Rd_Address, Data_Out => MEMDATA,
			WrtAddress => Mem_Wrt_Address, Data_in => DPU_Result,
			Tabloo_Addr => Tabloo_Addr, data_ready => data_ready, Tabloo_Data => Tabloo_Data);  

	Tab_comp: Tabloo_driver
		port 	map	(clk => clk, rst => rst,
					Refresh_data => data_ready, Tabloo_Mem_Data => Tabloo_Data, Tabloo_Mem_Addr => Tabloo_Addr,
					Tabloo_Mux => Mux, update_mux => update_mux, Tabloo_NegPin => NegPin, Tabloo_PosPin => PosPin);
	
	FlagOut <=	DPUFlags;
	output <= DPU_Result;
end RTL;
