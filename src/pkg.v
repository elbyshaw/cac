`ifndef PKG
`define PKG
		parameter NUM_BITS = 8;

    // represents dimension of arrays: N x N
    parameter N = 4;

    // number of bits needed to represent N elements
    parameter LOG_N = 2;

    typedef enum logic [1:0] {PASSTHROUGH, LOAD, PROCESS} input_mux_t;
		typedef enum logic [1:0] {S_IDLE, S_LOADING, S_PROCESSING, S_END } state_t;
`endif
