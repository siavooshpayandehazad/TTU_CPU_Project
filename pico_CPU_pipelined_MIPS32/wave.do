onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:rst
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:clk
add wave -noupdate -expand -group {Control Unit} -color Coral -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:PC_out
add wave -noupdate -expand -group {Control Unit} -color Coral -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:EPC_out
add wave -noupdate -expand -group {Control Unit} -color {Green Yellow} :picocputestbench:PicoCPU_comp:ControlUnit_comp:status_reg
add wave -noupdate -expand -group {Control Unit} -color Cyan  :picocputestbench:PicoCPU_comp:ControlUnit_comp:cause_reg
add wave -noupdate -expand -group {Control Unit} -group MEM_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:MemRdAddress
add wave -noupdate -expand -group {Control Unit} -group MEM_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:MemWrtAddress
add wave -noupdate -expand -group {Control Unit} -group MEM_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:Mem_RW
add wave -noupdate -expand -group {Control Unit} -group MEM_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:MEM_IN_SEL
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_Flags
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DataToDPU_1
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DataToDPU_2
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_ALUCommand
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_Mux_Cont_1
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_Mux_Cont_2
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_RESULT
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_RESULT_FF
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:HIGH_FF
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:LOW_FF
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:HIGH
add wave -noupdate -expand -group {Control Unit} -group DPU_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:LOW
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:RFILE_data_sel
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:RFILE_in_address
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:RFILE_WB_enable
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:RFILE_out_sel_1
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:RFILE_out_sel_2
add wave -noupdate -expand -group {Control Unit} -group RFILE_signals :picocputestbench:PicoCPU_comp:ControlUnit_comp:Data_to_RFILE
add wave -noupdate -expand -group {Control Unit} -color Yellow :picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_F
add wave -noupdate -expand -group {Control Unit} -color Salmon :picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_D
add wave -noupdate -expand -group {Control Unit} -color Cyan :picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_E
add wave -noupdate -expand -group {Control Unit} -color Magenta :picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_WB
add wave -noupdate -expand -group {Control Unit} -group REG_Dec -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rd_d
add wave -noupdate -expand -group {Control Unit} -group REG_Dec -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rt_d
add wave -noupdate -expand -group {Control Unit} -group REG_Dec -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rs_d
add wave -noupdate -expand -group {Control Unit} -group REG_Ex -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rd_ex
add wave -noupdate -expand -group {Control Unit} -group REG_Ex -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rt_ex
add wave -noupdate -expand -group {Control Unit} -group REG_Ex -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rs_ex
add wave -noupdate -expand -group {Control Unit} -group REG_WB -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rd_wb
add wave -noupdate -expand -group {Control Unit} -group REG_WB -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rt_wb
add wave -noupdate -expand -group {Control Unit} -group REG_WB -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:rs_wb
add wave -noupdate -expand -group {Control Unit} -group raw_Instructions :picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_In
add wave -noupdate -expand -group {Control Unit} -group raw_Instructions :picocputestbench:PicoCPU_comp:ControlUnit_comp:InstrReg_out_D
add wave -noupdate -expand -group {Control Unit} -group raw_Instructions :picocputestbench:PicoCPU_comp:ControlUnit_comp:InstrReg_out_E
add wave -noupdate -expand -group {Control Unit} -group raw_Instructions :picocputestbench:PicoCPU_comp:ControlUnit_comp:InstrReg_out_WB
add wave -noupdate -expand -group {Control Unit} -color Pink :picocputestbench:PicoCPU_comp:ControlUnit_comp:address_error
add wave -noupdate -expand -group {Control Unit} -color Pink :picocputestbench:PicoCPU_comp:ControlUnit_comp:Illigal_opcode
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:BRANCH_FIELD
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:BASE_D
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:OFFSET_EX
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:IMMEDIATE_EX
add wave -noupdate -expand -group {Control Unit} -radix unsigned :picocputestbench:PicoCPU_comp:ControlUnit_comp:sa_ex
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:SPECIAL_F
add wave -noupdate -expand -group {Control Unit} :picocputestbench:PicoCPU_comp:ControlUnit_comp:opcode_F
add wave -noupdate -expand -group RegFile :picocputestbench:PicoCPU_comp:RegFile_comp:rst
add wave -noupdate -expand -group RegFile :picocputestbench:PicoCPU_comp:RegFile_comp:clk
add wave -noupdate -expand -group RegFile -group Data_in -color Salmon :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_sel
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_mem
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_CU
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_DPU_LOW
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_DPU_HI
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_ACC_LOW
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_ACC_HI
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in_R2
add wave -noupdate -expand -group RegFile -group Data_in :picocputestbench:PicoCPU_comp:RegFile_comp:Data_in
add wave -noupdate -expand -group RegFile :picocputestbench:PicoCPU_comp:RegFile_comp:WB_enable
add wave -noupdate -expand -group RegFile -radix unsigned :picocputestbench:PicoCPU_comp:RegFile_comp:address_in
add wave -noupdate -expand -group RegFile -color Cyan -childformat {{:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(0) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(1) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(2) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(3) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(4) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(5) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(6) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(7) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(8) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(9) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(10) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(11) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(12) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(13) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(14) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(15) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(16) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(17) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(18) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(19) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(20) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(21) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(22) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(23) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(24) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(25) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(26) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(27) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(28) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(29) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(30) -radix unsigned} {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(31) -radix unsigned}} -subitemconfig {:picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(0) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(1) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(2) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(3) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(4) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(5) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(6) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(7) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(8) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(9) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(10) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(11) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(12) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(13) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(14) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(15) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(16) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(17) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(18) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(19) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(20) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(21) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(22) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(23) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(24) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(25) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(26) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(27) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(28) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(29) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(30) {-color Cyan -height 17 -radix unsigned} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE(31) {-color Cyan -height 17 -radix unsigned}} :picocputestbench:PicoCPU_comp:RegFile_comp:RFILE
add wave -noupdate -expand -group RegFile -group Output -radix unsigned :picocputestbench:PicoCPU_comp:RegFile_comp:Register_out_sel_1
add wave -noupdate -expand -group RegFile -group Output -radix unsigned :picocputestbench:PicoCPU_comp:RegFile_comp:Register_out_sel_2
add wave -noupdate -expand -group RegFile -group Output :picocputestbench:PicoCPU_comp:RegFile_comp:Data_out_1
add wave -noupdate -expand -group RegFile -group Output :picocputestbench:PicoCPU_comp:RegFile_comp:Data_out_2
add wave -noupdate -expand -group DPU :picocputestbench:PicoCPU_comp:DPU_comp:rst
add wave -noupdate -expand -group DPU :picocputestbench:PicoCPU_comp:DPU_comp:clk
add wave -noupdate -expand -group DPU -color Salmon :picocputestbench:PicoCPU_comp:DPU_comp:ALUCommand
add wave -noupdate -expand -group DPU -group Input -color Yellow :picocputestbench:PicoCPU_comp:DPU_comp:Mux_Cont_1
add wave -noupdate -expand -group DPU -group Input -color Yellow :picocputestbench:PicoCPU_comp:DPU_comp:Mux_Cont_2
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Data_in_mem
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Data_in_RegFile_1
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Data_in_RegFile_2
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Data_in_control_1
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Data_in_control_2
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Mux_Out_1
add wave -noupdate -expand -group DPU -group Input :picocputestbench:PicoCPU_comp:DPU_comp:Mux_Out_2
add wave -noupdate -expand -group DPU :picocputestbench:PicoCPU_comp:DPU_comp:ACC_in
add wave -noupdate -expand -group DPU :picocputestbench:PicoCPU_comp:DPU_comp:ACC_out
add wave -noupdate -expand -group DPU -group Flags :picocputestbench:PicoCPU_comp:DPU_comp:DPU_Flags
add wave -noupdate -expand -group DPU -group Flags :picocputestbench:PicoCPU_comp:DPU_comp:EQ_Flag
add wave -noupdate -expand -group DPU -group Flags :picocputestbench:PicoCPU_comp:DPU_comp:OV_Flag
add wave -noupdate -expand -group DPU -group Flags :picocputestbench:PicoCPU_comp:DPU_comp:Z_Flag
add wave -noupdate -expand -group DPU -group Flags :picocputestbench:PicoCPU_comp:DPU_comp:C_Flag
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:rst
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:clk
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:Data_in
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:WrtAddress
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:RW
add wave -noupdate -expand -group {Data Memory} -color Yellow :picocputestbench:PicoCPU_comp:Mem_comp:write_enable
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:RdAddress_1
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:RdAddress_2
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:Data_Out_1
add wave -noupdate -expand -group {Data Memory} :picocputestbench:PicoCPU_comp:Mem_comp:Data_Out_2
add wave -noupdate -expand -group {Data Memory} -color Cyan :picocputestbench:PicoCPU_comp:Mem_comp:Mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 613
configure wave -valuecolwidth 64
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {52500 ps}
