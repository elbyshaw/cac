set src "../src/v"

# import yosys commands as tcl commands
yosys -import

# read design files
read_verilog $src/*

# set top level
hierarchy -top top_lvl

# write to RTL Intermediate Language, a yosys processing format
write_rtlil

# convert process (always blocks) to netlist elements and perform some simple optimizations


