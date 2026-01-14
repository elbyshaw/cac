// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpkg.h for the primary calling header

#include "Vpkg__pch.h"
#include "Vpkg___024root.h"

VL_INLINE_OPT void Vpkg___024root___ico_sequent__TOP__0(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___ico_sequent__TOP__0\n"); );
    // Init
    CData/*7:0*/ pe__DOT__multiply;
    pe__DOT__multiply = 0;
    // Body
    pe__DOT__multiply = (0xffU & ((IData)(vlSelf->pe__DOT__stationary) 
                                  * (IData)(vlSelf->left_i)));
    vlSelf->pe__DOT__result = (0xffU & ((IData)(vlSelf->add_zero_i)
                                         ? (IData)(pe__DOT__multiply)
                                         : ((IData)(pe__DOT__multiply) 
                                            + (IData)(vlSelf->top_i))));
}

void Vpkg___024root___eval_ico(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vpkg___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void Vpkg___024root___eval_triggers__ico(Vpkg___024root* vlSelf);

bool Vpkg___024root___eval_phase__ico(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    Vpkg___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        Vpkg___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vpkg___024root___eval_act(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vpkg___024root___nba_sequent__TOP__0(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*7:0*/ pe__DOT__multiply;
    pe__DOT__multiply = 0;
    // Body
    if (vlSelf->rst_i) {
        vlSelf->right_o = 0U;
        vlSelf->bottom_o = 0U;
        vlSelf->pe__DOT__stationary = 0U;
    } else {
        vlSelf->right_o = vlSelf->left_i;
        if ((0U == (IData)(vlSelf->mux_i))) {
            vlSelf->bottom_o = vlSelf->top_i;
        } else if ((1U != (IData)(vlSelf->mux_i))) {
            if ((2U == (IData)(vlSelf->mux_i))) {
                vlSelf->bottom_o = vlSelf->pe__DOT__result;
            }
        }
        if ((0U != (IData)(vlSelf->mux_i))) {
            if ((1U == (IData)(vlSelf->mux_i))) {
                vlSelf->pe__DOT__stationary = vlSelf->top_i;
            }
        }
    }
    pe__DOT__multiply = (0xffU & ((IData)(vlSelf->pe__DOT__stationary) 
                                  * (IData)(vlSelf->left_i)));
    vlSelf->pe__DOT__result = (0xffU & ((IData)(vlSelf->add_zero_i)
                                         ? (IData)(pe__DOT__multiply)
                                         : ((IData)(pe__DOT__multiply) 
                                            + (IData)(vlSelf->top_i))));
}

void Vpkg___024root___eval_nba(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vpkg___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vpkg___024root___eval_triggers__act(Vpkg___024root* vlSelf);

bool Vpkg___024root___eval_phase__act(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vpkg___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vpkg___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vpkg___024root___eval_phase__nba(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vpkg___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vpkg___024root___dump_triggers__ico(Vpkg___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vpkg___024root___dump_triggers__nba(Vpkg___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vpkg___024root___dump_triggers__act(Vpkg___024root* vlSelf);
#endif  // VL_DEBUG

void Vpkg___024root___eval(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelf->__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            Vpkg___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("pe.sv", 3, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vpkg___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vpkg___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("pe.sv", 3, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vpkg___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("pe.sv", 3, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vpkg___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vpkg___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vpkg___024root___eval_debug_assertions(Vpkg___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vpkg__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpkg___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk_i & 0xfeU))) {
        Verilated::overWidthError("clk_i");}
    if (VL_UNLIKELY((vlSelf->rst_i & 0xfeU))) {
        Verilated::overWidthError("rst_i");}
    if (VL_UNLIKELY((vlSelf->mux_i & 0xfcU))) {
        Verilated::overWidthError("mux_i");}
    if (VL_UNLIKELY((vlSelf->add_zero_i & 0xfeU))) {
        Verilated::overWidthError("add_zero_i");}
}
#endif  // VL_DEBUG
