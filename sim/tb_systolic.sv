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
	)

	// generate clock
	initial begin
		clk = 0;
		forever #(CLK_PERIOD/2) clk = ~clk;
	end

	// generate reset
	initial begin
		rst = 1'b1;
		#CLK_PERIOD
		reset = 1'b0;
	end

	// test stimulus
	initial begin
		/* cac/res/SystolicExplained.pptx 
		explains how this should function */

		// input 1:

		$finish
	end

	initial begin
		/* Test 1: Identity multiply
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

		// cycle 0
		in_north = '{}
		


		// not sure how to present data best
		// $monitor("Time %0t", $time);
	end
endmodule