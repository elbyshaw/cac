// These should come from "Verilating" the file "our.v" (in the example)
// SHOULD happen automatically while calling Verilator

// "common routines"
#include <verilated.h>

// generated from verilating "pe.sv"
// BUG?: might need to use Verilog (pe.v) not SystemVerilog (top_lvl.sv)
#include "Vcounter.h"

// This file acts as the 'user-made' C++ file needed 
// for verilator simulation.

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vcounter* counter = new Vcounter{contextp};
    while (!contextp->gotFinish()) { counter->eval(); }
    delete counter;
    delete contextp;
    return 0;
}
