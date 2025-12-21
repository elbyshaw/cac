set src "../src/v"

# import yosys commands as tcl commands
yosys -import
read_verilog -sv $src/pkg.sv $src/pe.sv

