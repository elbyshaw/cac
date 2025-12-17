module controller import pkg::*;(
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,
		
		input logic ready_i,


		output input_mux_t mux_o [N][N],
		output logic add_zero_o [N][N],
);
		
		state_t state, next;
		int i, j;

		logic [LOG_N+2:0] counter;
		
		always_ff @(posedge clk_i) begin
			if (rst_i) begin
				state <= S_IDLE;
			
				// clear control matrices
				for (i = 0; i < N; i++) begin
					for (j = 0; j < N; j++) begin
						mux_o[i][j] <= '0;	
						add_zero_o[i][j] <= '0;	
					end
				end
			end else begin
				state <= next;	
			end
		end	

		// set next state
		always_ff @(posedge clk_i) begin
				
		end	



		always_comb begin

		end
	
endmodule
