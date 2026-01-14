package pkg;
    // ============== GLOBAL PARAMETERS =================
    // number of bits in each integer
		parameter NUM_BITS = 8;

    // represents dimension of arrays: N x N
    parameter N = 4;

    // number of bits needed to represent N elements
    parameter LOG_N = 2;

    // enums for state management
    typedef enum logic [1:0] {PASSTHROUGH, LOAD, PROCESS} input_mux_t;
		typedef enum logic [1:0] {S_IDLE, S_LOADING, S_PROCESSING, S_END } state_t;



    // =============== INPUT DATA ===============

    // Matrix A, of weights coming in from top direction
    // These provide input for the weight_buf
    localparam logic [NUM_BITS-1:0] A_MATRIX [0:N-1][0:N-1] = '{
      '{1'b1, 1'b0, 1'b0, 1'b0},
      '{1'b0, 1'b1, 1'b0, 1'b0},
      '{1'b0, 1'b0, 1'b1, 1'b0},
      '{1'b0, 1'b0, 1'b0, 1'b1}
    };

    // Matrix B, of input coming in from left direction
    // These provide input for the input_act_buf
    localparam logic [NUM_BITS-1:0] B_MATRIX [0:N-1][0:N-1] = '{
      '{1'b1, 1'b0, 1'b0, 1'b0},
      '{1'b0, 1'b1, 1'b0, 1'b0},
      '{1'b0, 1'b0, 1'b1, 1'b0},
      '{1'b0, 1'b0, 1'b0, 1'b1}
    };


endpackage
