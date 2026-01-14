// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VPKG__SYMS_H_
#define VERILATED_VPKG__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vpkg.h"

// INCLUDE MODULE CLASSES
#include "Vpkg___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vpkg__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vpkg* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vpkg___024root                 TOP;

    // CONSTRUCTORS
    Vpkg__Syms(VerilatedContext* contextp, const char* namep, Vpkg* modelp);
    ~Vpkg__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
