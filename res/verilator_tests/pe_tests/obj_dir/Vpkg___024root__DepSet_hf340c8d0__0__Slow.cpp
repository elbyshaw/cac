// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpkg.h for the primary calling header

#include "Vpkg__pch.h"
#include "Vpkg__Syms.h"
#include "Vpkg___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vpkg___024root___dump_triggers__stl(Vpkg___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vpkg___024root___eval_triggers__stl(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vpkg___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
