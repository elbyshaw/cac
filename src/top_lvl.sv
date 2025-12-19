/*
 * MODULE UNFINISHED
 * I'm not sure how to handle inputs for the left and top side of the PE array.
 *
 * I handled this by leaving the inputs for the i = 0 and j = 0 rows/columns of n_s 
 * and e_w wires (respectively) undefined. So this NEEDS TO BE FIXED.
 * - Nick
 */

module top_lvl import pkg::*; (
    input logic clk,
    input logic rst

    // inputs needed here?
);

    // =================== WIRES ==================
    // wires running north-south above and below PEs
    // N+1 x N because there are wires both above and below
    logic [NUM_BITS-1:0] n_s [N+1][N];
    // wires running east-west to the left and right of PEs
    // extra wires to the right go nowhere
    logic [NUM_BITS-1:0] e_w [N][N+1];

    // outputs from controller to PEs
    input_mux_t mux [N][N];
    logic add_zero [N][N];

    // output from controller to accumulators
    logic acc_valid [N];

    controller ctrl (
        .clk_i          (clk),
        .rst_i          (rst),
        .ready_i        (/*[BLANK]*/),
        .mux_o          (mux),
        .add_zero_o     (add_zero),
        .acc_valid_o    (acc_valid)
    );

    // generate N x N PEs
    generate
        for (genvar i = 0; i < N; i++) begin
            for (genvar j = 0; j < N; j++) begin
                pe pe_ij (
                    .clk_i      (clk),
                    .rst_i      (rst),
                    .top_i      (n_s[i][j]),
                    .left_i     (e_w[i][j]),
                    .bottom_o   (n_s[i+1][j]),
                    .right_o    (e_w[i][j+1]),

                    .mux_i      (mux[i][j]),
                    .add_zero_i (add_zero[i][j])
                );
            end

            // generate N accumulators on hooked to bottom of n_s wires
            accumulator acc (
                .clk_i      (clk),
                .rst_i      (rst),
                .C_i        (n_s[N+1][i]),
                .product_o  (/*[BLANK]*/),
                .valid_i    (acc_valid[i])
            );
        end
    endgenerate


endmodule