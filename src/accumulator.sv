module pe import pkg::*;(
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,

    // DATA INPUTS / OUTPUTS
    /* One row of elements in final C array;
       takes N elements each NUM_BITS wide */
    input logic [NUM_BITS-1:0] C_i [N],
    output logic [NUM_BITS-1:0] product_0 [N][N], 

    // CONTROL SIGNAL
    
    );

    int i,j;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            for (i = 0; i < N; i++) 
                for (j = 0; j < N; j++)
                    product_o[i][j] <= '0;
        end else begin
            for (i = 0; i < N; i++) 
                
        end
    end

endmodule