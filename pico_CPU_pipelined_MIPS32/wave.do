add wave -noupdate  sim/:picocputestbench:clk
add wave -noupdate  sim/:picocputestbench:rst

add wave -noupdate -group {Control Unit}  sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:*
# add wave -noupdate -group {Control Unit} -color Gold -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:PC_out
# add wave -noupdate -group {Control Unit} -color Gold sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:opcode_in
# add wave -noupdate -group {Control Unit} -color Gold sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_D
# add wave -noupdate -group {Control Unit} -color Gold sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_E
# add wave -noupdate -group {Control Unit} -color Gold sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:Instr_WB
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:SP_out
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:MemRdAddress
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:MemWrtAddress
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:DPU_Flags
# add wave -noupdate -group {Control Unit}  sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:CommandToDPU
# add wave -noupdate -group {Control Unit}  sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:Reg_in_sel
# add wave -noupdate -group {Control Unit}  sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:Reg_out_sel
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:DataFromDPU
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:SP_in
# add wave -noupdate -group {Control Unit} -radix decimal sim/:picocputestbench:PicoCPU_comp:ControlUnit_comp:PC_in

add wave -noupdate -group {RegFile}  sim/:picocputestbench:PicoCPU_comp:RegFile_comp:*

add wave -noupdate -group {DPU} sim/:picocputestbench:PicoCPU_comp:DPU_comp:*
add wave -noupdate -group {Inst Memory} sim/:picocputestbench:PicoCPU_comp:InstMem_comp:*
add wave -noupdate -group {Data Memory} sim/:picocputestbench:PicoCPU_comp:Mem_comp:*
