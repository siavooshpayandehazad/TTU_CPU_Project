################################################
# Copyright (C) 2016 siavoosh Payandeh Azad    #
################################################

vlib work

# Include files and compile them
vcom "package.vhd"
vcom "GPIO.vhd"

vcom "ALU.vhd"
vcom "Controller.vhd"
vcom "DPU.vhd"
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
run 1000 ns
vcd flush
