import pkg::*;

module input_act_buf (
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,

    // DATA INPUT / OUTPUTS
    // no input; gets data on reset
    output logic [NUM_BITS-1:0] B_o [0:N-1],

    // CONTROL SIGNAL
    input logic valid_i
    );

    logic [NUM_BITS-1:0] matrix [0:(2*N)-1][0:N-1];
    logic [LOG_N+2:0] counter;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            counter <= '0;

            // column 0
            matrix[0][0] <= B_MATRIX[0][0];
            matrix[0][1] <= '0;
            matrix[0][2] <= '0;
            matrix[0][3] <= '0;

            // column 1
            matrix[1][0] <= B_MATRIX[0][1];
            matrix[1][1] <= B_MATRIX[1][0];
            matrix[1][2] <= '0;
            matrix[1][3] <= '0;

            // column 2
            matrix[2][0] <= B_MATRIX[0][2];
            matrix[2][1] <= B_MATRIX[1][1];
            matrix[2][2] <= B_MATRIX[2][0];
            matrix[2][3] <= '0;

            // column 3
            matrix[3][0] <= B_MATRIX[0][3];
            matrix[3][1] <= B_MATRIX[1][2];
            matrix[3][2] <= B_MATRIX[2][1];
            matrix[3][3] <= B_MATRIX[3][0];

            // column 4
            matrix[4][0] <= 0;
            matrix[4][1] <= B_MATRIX[1][3];
            matrix[4][2] <= B_MATRIX[2][2];
            matrix[4][3] <= B_MATRIX[3][1];

            // column 5
            matrix[5][0] <= 0;
            matrix[5][1] <= 0;
            matrix[5][2] <= B_MATRIX[2][3];
            matrix[5][3] <= B_MATRIX[3][2];

            // column 6
            matrix[6][0] <= 0;
            matrix[6][1] <= 0;
            matrix[6][2] <= 0;
            matrix[6][3] <= B_MATRIX[3][3];

        end else begin
            if (valid_i)
                counter <= counter + 1;
        end
    end
    
    always_comb begin
        if (!rst_i && valid_i) begin
            for (int i = 0; i < N; i++) begin
                B_o[i] = matrix[counter-1][i];
            end
        end
    end
    
endmodule