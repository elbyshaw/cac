// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpkg.h for the primary calling header

#include "Vpkg__pch.h"
#include "Vpkg__Syms.h"
#include "Vpkg___024unit.h"

void Vpkg___024unit___ctor_var_reset(Vpkg___024unit* vlSelf);

Vpkg___024unit::Vpkg___024unit(Vpkg__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vpkg___024unit___ctor_var_reset(this);
}

void Vpkg___024unit::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vpkg___024unit::~Vpkg___024unit() {
}
