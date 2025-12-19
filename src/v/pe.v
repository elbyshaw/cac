module pe (
	clk_i,
	rst_i,
	top_i,
	left_i,
	right_o,
	bottom_o,
	mux_i,
	add_zero_i
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_i;
	localparam pkg_NUM_BITS = 8;
	input wire [7:0] top_i;
	input wire [7:0] left_i;
	output reg [7:0] right_o;
	output reg [7:0] bottom_o;
	input wire [1:0] mux_i;
	input wire add_zero_i;
	reg [7:0] stationary;
	reg [7:0] result;
	always @(posedge clk_i)
		if (rst_i) begin
			right_o <= 1'sb0;
			bottom_o <= 1'sb0;
			stationary <= 1'sb0;
		end
		else begin
			right_o <= left_i;
			case (mux_i)
				2'd0: bottom_o <= top_i;
				2'd1: stationary <= top_i;
				2'd2: bottom_o <= result;
			endcase
		end
	reg [7:0] multiply;
	always @(*) begin
		if (_sv2v_0)
			;
		multiply = stationary * left_i;
		if (add_zero_i == 1'b1)
			result = multiply;
		else
			result = multiply + top_i;
	end
	initial _sv2v_0 = 0;
endmodule
