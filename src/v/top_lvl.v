module top_lvl (
	clk,
	rst,
	north_i,
	west_i,
	C_o
);
	reg _sv2v_0;
	input wire clk;
	input wire rst;
	localparam pkg_N = 4;
	localparam pkg_NUM_BITS = 8;
	input wire [31:0] north_i;
	input wire [31:0] west_i;
	output wire [127:0] C_o;
	reg [7:0] n_s [0:4][0:3];
	reg [7:0] e_w [0:3][0:4];
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
	always @(*) begin
		if (_sv2v_0)
			;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < pkg_N; i = i + 1)
				begin
					n_s[0][i] = north_i[(3 - i) * 8+:8];
					e_w[i][0] = west_i[(3 - i) * 8+:8];
				end
		end
	end
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < pkg_N; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			genvar _gv_j_1;
			for (_gv_j_1 = 0; _gv_j_1 < pkg_N; _gv_j_1 = _gv_j_1 + 1) begin : genblk1
				localparam j = _gv_j_1;
				wire [8:1] sv2v_tmp_pe_ij_bottom_o;
				always @(*) n_s[i + 1][j] = sv2v_tmp_pe_ij_bottom_o;
				wire [8:1] sv2v_tmp_pe_ij_right_o;
				always @(*) e_w[i][j + 1] = sv2v_tmp_pe_ij_right_o;
				pe pe_ij(
					.clk_i(clk),
					.rst_i(rst),
					.top_i(n_s[i][j]),
					.left_i(e_w[i][j]),
					.bottom_o(sv2v_tmp_pe_ij_bottom_o),
					.right_o(sv2v_tmp_pe_ij_right_o),
					.mux_i(mux[(((3 - i) * 4) + (3 - j)) * 2+:2]),
					.add_zero_i(add_zero[((3 - i) * 4) + (3 - j)])
				);
			end
			accumulator acc(
				.clk_i(clk),
				.rst_i(rst),
				.C_i(n_s[5][i]),
				.product_o(C_o[8 * ((3 - i) * 4)+:32]),
				.valid_i(acc_valid[i])
			);
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
