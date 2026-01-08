// These should come from "Verilating" the file "our.v" (in the example)
// ^? I'm really not sure where these are supposed to be coming from

// "common routines"
#include <verilated.h>

// generated from verilating "top_lvl.sv"
// BUG?: might need to use Verilog (top_lvl.v) not SystemVerilog (top_lvl.sv)
#include "Vtop_lvl.h"

// This file acts as the 'user-made' C++ file needed 
// for verilator simulation.

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop_lvl* top = new Vtop_lvl{contextp};
    while (!contextp->gotFinish()) { top->eval(); }
    delete top;
    delete contextp;
    return 0;
}
