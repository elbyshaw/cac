This can be run once verilator is installed by running: 

verilator -cc --exe --build -j 0 -Wall pe_sim.cpp pkg.sv pe.sv

Note: some changes were made to pe.sv to accomodate verilator warnings. This may need to be fixed in the main files as well. There are ALL CAPS comments in the places where changes were made.

Currently running into errors on this (Vpe.h not being created/found). This may be because its a .sv file. I am creating a separate folder with a test for a simple counter in Verilog to see if that is the issue.

Note: the simple counter using just Verilog works. Notes in the README in that folder.
