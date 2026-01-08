This can be run once verilator is installed by running: 

verilator -cc --exe --build -j 0 -Wall verilator_sim.cpp pkg.sv pe.sv

Note: some changes were made to pe.sv to accomodate verilator warnings. This may need to be fixed in the main files as well. There are ALL CAPS comments in the places where changes were made.


