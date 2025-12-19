module controller (
	clk_i,
	rst_i,
	ready_i,
	mux_o,
	add_zero_o,
	acc_valid_o
);
	input wire clk_i;
	input wire rst_i;
	input wire ready_i;
	localparam pkg_N = 4;
	output reg [31:0] mux_o;
	output reg [15:0] add_zero_o;
	output reg [0:3] acc_valid_o;
	reg [1:0] state;
	reg [1:0] next;
	reg signed [31:0] i;
	reg signed [31:0] j;
	localparam pkg_LOG_N = 2;
	wire [4:0] counter;
	reg [8:0] acc_mask;
	always @(posedge clk_i)
		if (rst_i) begin
			state <= 2'd0;
			for (i = 0; i < pkg_N; i = i + 1)
				for (j = 0; j < pkg_N; j = j + 1)
					begin
						mux_o[(((3 - i) * 4) + (3 - j)) * 2+:2] <= 1'sb0;
						add_zero_o[((3 - i) * 4) + (3 - j)] <= 1'sb0;
					end
		end
		else
			state <= next;
	always @(posedge clk_i)
		case (state)
			2'd0: next <= S_READ;
			2'd1:
				if (counter <= pkg_N)
					next <= 2'd1;
				else
					next <= 2'd2;
			2'd2:
				if (counter <= 11)
					next <= 2'd2;
				else
					next <= 2'd3;
			2'd3: next <= 2'd3;
		endcase
	always @(posedge clk_i)
		case (state)
			2'd0:
				;
			2'd1:
				if (counter < 3) begin
					for (i = 0; i < pkg_N; i = i + 1)
						for (j = 0; j < pkg_N; j = j + 1)
							if (counter < 3)
								mux_o[(((3 - i) * 4) + (3 - j)) * 2+:2] <= 2'd0;
							else
								mux_o[(((3 - i) * 4) + (3 - j)) * 2+:2] <= 2'd1;
				end
			2'd2:
				for (i = 0; i < pkg_N; i = i + 1)
					for (j = 0; j < pkg_N; j = j + 1)
						begin
							if (i == 0)
								add_zero_o[((3 - i) * 4) + (3 - j)] <= 1'b1;
							else
								add_zero_o[((3 - i) * 4) + (3 - j)] <= 1'sb0;
							mux_o[(((3 - i) * 4) + (3 - j)) * 2+:2] <= 2'd2;
						end
			2'd3:
				;
		endcase
	always @(posedge clk_i)
		case (state)
			2'd0: begin
				acc_mask <= {{pkg_N {1'b1}} << pkg_N};
				for (i = 0; i < pkg_N; i = i + 1)
					acc_valid_o[i] <= 1'sb0;
			end
			2'd1:
				for (i = 0; i < pkg_N; i = i + 1)
					acc_valid_o[i] <= 1'sb0;
			2'd2: begin
				if (counter >= pkg_N)
					acc_mask <= acc_mask >> 1;
				for (i = 0; i < pkg_N; i = i + 1)
					acc_valid_o[i] <= acc_mask[i];
			end
			2'd3:
				for (i = 0; i < pkg_N; i = i + 1)
					acc_valid_o[i] <= 1'sb0;
		endcase
endmodule
