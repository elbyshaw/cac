`include "pkg.v"
module pe 
	(
	// clock and reset
	input logic clk_i,
	input logic rst_i,

	// primary inputs and outputs
	input logic [NUM_BITS-1:0] top_i,
	input logic [NUM_BITS-1:0] left_i,
	// these ones are registers?
	output logic [NUM_BITS-1:0] right_o,
	output logic [NUM_BITS-1:0] bottom_o,

	// control signals
	input input_mux_t mux_i,
	input logic add_zero_i // logic high
	);

	// internal register to track A
	logic [NUM_BITS-1:0] stationary;
	logic [NUM_BITS-1:0] result;

	always_ff @(posedge clk_i) begin
		if (rst_i) begin
			right_o <= '0;
			bottom_o <= '0;
			stationary <= '0;
		end else begin
			// always propagate B 
			right_o <= left_i;	
			case (mux_i) 
				PASSTHROUGH: begin
					bottom_o <= top_i;
				end			
				LOAD: begin
					stationary <= top_i;
				end
				PROCESS: begin
					bottom_o <= result;
				end
			endcase
		end	
	end

	logic [NUM_BITS-1:0] multiply;	

	always_comb begin
		multiply = stationary * left_i;
		if (add_zero_i == 1'b1) begin
			result = multiply; // DONT add anything
		end else begin
			result = multiply + top_i; // add previous sum (C)		
		end
	end
endmodule
