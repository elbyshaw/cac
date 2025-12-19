module top_lvl (
	clk,
	rst
);
	input wire clk;
	input wire rst;
	localparam pkg_N = 4;
	localparam pkg_NUM_BITS = 8;
	wire [7:0] n_s [0:4][0:3];
	wire [7:0] e_w [0:3][0:4];
	wire [31:0] mux;
	wire [15:0] add_zero;
	wire [0:3] acc_valid;
	controller ctrl(
		.clk_i(clk),
		.rst_i(rst),
		.ready_i(),
		.mux_o(mux),
		.add_zero_o(add_zero),
		.acc_valid_o(acc_valid)
	);
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < pkg_N; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			genvar _gv_j_1;
			for (_gv_j_1 = 0; _gv_j_1 < pkg_N; _gv_j_1 = _gv_j_1 + 1) begin : genblk1
				localparam j = _gv_j_1;
				pe pe_ij(
					.clk_i(clk),
					.rst_i(rst),
					.top_i(n_s[i][j]),
					.left_i(e_w[i][j]),
					.bottom_o(n_s[i + 1][j]),
					.right_o(e_w[i][j + 1]),
					.mux_i(mux[(((3 - i) * 4) + (3 - j)) * 2+:2]),
					.add_zero_i(add_zero[((3 - i) * 4) + (3 - j)])
				);
			end
			accumulator acc(
				.clk_i(clk),
				.rst_i(rst),
				.C_i(n_s[5][i]),
				.product_o(),
				.valid_i(acc_valid[i])
			);
		end
	endgenerate
endmodule
