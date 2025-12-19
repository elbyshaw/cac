module accumulator import pkg::*; (
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,

    // DATA INPUT / OUTPUTS
    // One element in final C array
    input logic [NUM_BITS-1:0] C_i,
    // N registers NUM_BITS wide
    output logic [NUM_BITS-1:0] product_o [N],

    // CONTROL SIGNAL
    input logic valid_i
    );

    int i;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            for (i = 0; i < N; i++) 
                product_o[i] <= '0;
        end else begin
            if (valid_i) begin
                product_o[0] <= C_i;
                for (i = 1; i < N; i++) begin
                    product_o[i] <= product_o[i - 1];
                end
            end
        end
    end

endmodule
