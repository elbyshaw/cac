import pkg::*;

module weight_buf (
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,

    // DATA INPUT / OUTPUTS
    // no input; gets data on reset
    output logic [NUM_BITS-1:0] A_o [0:N-1],

    // CONTROL SIGNAL
    input logic valid_i
    );

    logic [LOG_N+1:0] counter;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            counter <= '0;
        end else begin
            if (valid_i)
                counter <= counter + 1;
        end
    end
    
    always_comb begin
        if (!rst_i && valid_i) begin
            for (int i = 0; i < N; i++) begin
                // BUG?: could be an issue with this math
                A_o[i] = A_MATRIX[i][N - counter];
            end
        end
    end

endmodule