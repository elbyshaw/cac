`timescale 1ns / 1ps
// coop says this doesnt matter
// but we may need to set it regardless
module tb_systolic ();
	parameter CLK_PERIOD = 10;

	// ========= SIGNALS ==========
	logic clk;
	logic rst;
	logic [NUM_BITS-1:0] in_north [N];
	logic [NUM_BITS-1:0] in_west [N];
	logic [NUM_BITS-1:0] out_C [N][N];

	top_lvl dut (
		.clk		(clk),
		.rst		(rst),
		.north_i	(in_north),
		.west_i		(in_west),
		.C_o		(out_C)
	);

	// generate clock
	initial begin
		clk = 0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// generate reset
	initial begin
		rst = 1'b1;
		#CLK_PERIOD
		rst = 1'b0;
	end

	// test stimulus
	initial begin
				/* Test 1: Identity multiply
		   SIZE: N = 4
		A =	{1 0 0 0
			 0 1 0 0
			 0 0 1 0
			 0 0 0 1}

		B =	{1 0 0 0
			 0 1 0 0
			 0 0 1 0
			 0 0 0 1}

		C =	{1 0 0 0
			 0 1 0 0
			 0 0 1 0
			 0 0 0 1} */

		// LOADING PHASE
		// cycle 0
		in_north = '{0, 0, 0, 1'b1};
		#CLK_PERIOD
		// cycle 1
		in_north = '{0, 0, 1'b1, 0};
		#CLK_PERIOD
		// cycle 2
		in_north = '{0, 1'b1, 0, 0};
		#CLK_PERIOD
		// cycle 3
		in_north = '{1'b1, 0, 0, 0};
		#CLK_PERIOD

		//PROCESSING PHASE
		// cycle 4
		in_west[0] = 1'b1;
		#CLK_PERIOD
		// cycle 5
		in_west[0] = 0;
		in_west[1] = 0;
		#CLK_PERIOD
		// cycle 6
		in_west[0] = 0;
		in_west[1] = 1;
		in_west[2] = 0;
		#CLK_PERIOD
		// cycle 7
		in_west[0] = 0;
		in_west[1] = 0;
		in_west[2] = 0;
		in_west[3] = 0;
		#CLK_PERIOD
		// cycle 8
		in_west[1] = 0;
		in_west[2] = 1;
		in_west[3] = 0;
		#CLK_PERIOD
		// cycle 9
		in_west[2] = 0;
		in_west[3] = 0;
		#CLK_PERIOD
		// cycle 10
		in_west[3] = 1;
		#CLK_PERIOD
		// cycle 11
		in_west[3] = 0;
		#CLK_PERIOD
		#(CLK_PERIOD * 5) // necessary for data to finish computing

		#(CLK_PERIOD * 5) // extra wait time

		$finish;
	end

	initial begin

		// not sure how to present data best
		// $monitor("Time %0t", $time);
	end
endmodule