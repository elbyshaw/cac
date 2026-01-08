// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vpkg.h for the primary calling header

#ifndef VERILATED_VPKG___024UNIT_H_
#define VERILATED_VPKG___024UNIT_H_  // guard

#include "verilated.h"


class Vpkg__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vpkg___024unit final : public VerilatedModule {
  public:

    // INTERNAL VARIABLES
    Vpkg__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vpkg___024unit(Vpkg__Syms* symsp, const char* v__name);
    ~Vpkg___024unit();
    VL_UNCOPYABLE(Vpkg___024unit);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
