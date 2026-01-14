// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vpkg.h for the primary calling header

#ifndef VERILATED_VPKG___024ROOT_H_
#define VERILATED_VPKG___024ROOT_H_  // guard

#include "verilated.h"


class Vpkg__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vpkg___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk_i,0,0);
    VL_IN8(rst_i,0,0);
    VL_IN8(top_i,7,0);
    VL_IN8(left_i,7,0);
    VL_OUT8(right_o,7,0);
    VL_OUT8(bottom_o,7,0);
    VL_IN8(mux_i,1,0);
    VL_IN8(add_zero_i,0,0);
    CData/*7:0*/ pe__DOT__stationary;
    CData/*7:0*/ pe__DOT__result;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk_i__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vpkg__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vpkg___024root(Vpkg__Syms* symsp, const char* v__name);
    ~Vpkg___024root();
    VL_UNCOPYABLE(Vpkg___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
