module accumulator (
	clk_i,
	rst_i,
	C_i,
	product_o,
	valid_i
);
	input wire clk_i;
	input wire rst_i;
	localparam pkg_NUM_BITS = 8;
	input wire [7:0] C_i;
	localparam pkg_N = 4;
	output reg [31:0] product_o;
	input wire valid_i;
	reg signed [31:0] i;
	always @(posedge clk_i)
		if (rst_i)
			for (i = 0; i < pkg_N; i = i + 1)
				product_o[(3 - i) * 8+:8] <= 1'sb0;
		else if (valid_i) begin
			product_o[24+:8] <= C_i;
			for (i = 1; i < pkg_N; i = i + 1)
				product_o[(3 - i) * 8+:8] <= product_o[(4 - i) * 8+:8];
		end
endmodule
