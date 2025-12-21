import pkg::*; 

module controller (
    // CLOCK AND RESET
    input logic clk_i,
    input logic rst_i,
		
	// not sure what this is for? 
	input logic ready_i,

	// =========== PE CONTROLS ===========
	// tells each PE which mux state should be active
	output input_mux_t mux_o [N][N],
	// tells each PE if it should add 0 or the north input; logic high
	output logic add_zero_o [N][N],

	// ======== ACCUMULATOR CONTROLS =========
	output logic acc_valid_o [N]
);
	state_t state, next;
	int i, j;

	logic [LOG_N+2:0] counter;
	logic [2*N:0] acc_mask;
	
	// rotates states
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
	// BUG?: TIMING MAY NEED TO BE ADJUSTED
	always_ff @(posedge clk_i) begin
		case (state)
			S_IDLE: begin
				next <= S_READ;
			end

			S_LOADING: begin
				// should be N cycles of loading in stationary A values
				if (counter <= N) 
					next <= S_LOADING;
				else 
					next <= S_PROCESSING;
			end

			S_PROCESSING: begin
				// should be 3N-1 cycles of processing
				if (counter <= (3 * N) - 1)
					next <= S_PROCESSING;
				else 
					next <= S_END;
			end

			S_END: begin
				next <= S_END;
			end
		endcase
	end	

	// controls PEs
	always_ff @(posedge clk_i) begin
		case (state)
			S_IDLE: begin
				// do nothing
			end

			S_LOADING: begin
				//BUG?: TIMING MAY NEED TO BE ADJUSTED
				if (counter < 3) begin
					for (i = 0; i < N; i++) begin
						for (j = 0; j < N; j++) begin
							if (counter < 3)
								mux_o[i][j] <= PASSTHROUGH;
							else 
								mux_o[i][j] <= LOAD;
						end
					end
				end
			end

			S_PROCESSING: begin
				/* for power efficiency could send PEs to 
				 	idle when not processing but we're
				 	not implementing that at this point */
				for (i = 0; i < N; i++) begin
					for (j = 0; j < N; j++) begin
						if (i == 0) begin
							add_zero_o[i][j] <= 1'b1;
						end else begin
							add_zero_o[i][j] <= '0;
						end 
						mux_o[i][j] <= PROCESS;
					end
				end
			end

			S_END: begin
			
			end
		endcase
	end

	// controls PEs
	always_ff @(posedge clk_i) begin
		case (state)
			S_IDLE: begin
				// create mask for accumulator activation
				acc_mask <= { {N{1'b1}} << N };

				for (i = 0; i < N; i++) 
					acc_valid_o[i] <= '0;
			end

			S_LOADING: begin
				for (i = 0; i < N; i++) 
					acc_valid_o[i] <= '0;
			end

			S_PROCESSING: begin
				// once N cycles have passed start shifting acc_mask
				// BUG?: TIMING MAY NEED TO BE ADJUSTED
				if (counter >= N)
					// not sure when exactly this happens in the process?
					acc_mask <= acc_mask >> 1;

				for (i = 0; i < N; i++)
					acc_valid_o[i] <= acc_mask[i];
			end

			S_END: begin
				for (i = 0; i < N; i++) 
					acc_valid_o[i] <= '0;
			end
		endcase
	end
endmodule
