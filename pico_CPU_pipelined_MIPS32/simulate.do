################################################
# Copyright (C) 2016 siavoosh Payandeh Azad    #
################################################

vlib work

# Include files and compile them
vcom "package.vhd"
vcom "GPIO.vhd"
vcom "Adder.vhd"
vcom "FullAdder.vhd"
vcom "ALU.vhd"
vcom "Controller.vhd"
vcom "DPU.vhd"
vcom "InstMem.vhd"
vcom "Memory.vhd"
vcom "RegisterFile.vhd"
vcom "PicoCPU.vhd"
vcom "PicoTestBench.vhd"


# Start the simulation
vsim work.PicoCPUTestBench

# Draw waves
do wave.do
# Run the simulation
vcd file wave.vcd
vcd add -r -optcells /*
run 30 ns
vcd flush
