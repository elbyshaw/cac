/*
* Module describing a 32-bit ripple carry adder, with no carry output or input
*/
module adder32 import calculator_pkg::*; (
    input logic [DATA_W - 1 : 0] a_i,
    input logic [DATA_W - 1 : 0] b_i,
    output logic [DATA_W - 1 : 0] sum_o
);

    logic [DATA_W - 1 : 0] cout;

    full_adder fa_0 (a_i[i], b_i[i], 1'b0, sum_o[i], cout[0]);

    //TODO: use a generate block to chain together 32 full adders. 
    // Imagine you are connecting 32 single-bit adder modules together. 
    generate 
        for (genvar i = 1; i < DATA_W; i++) begin
            full_adder fa_g (a_i[i], b_i[i], cout[i - 1], sum_o[i], cout[i]);
        end
    endgenerate

endmodule