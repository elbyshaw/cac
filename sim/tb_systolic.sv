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
	// initial begin
	// 	rst = 1'b1;
	// 	@(posedge clk);
	// 	rst = 1'b0;
	// end

	// test stimulus
	initial begin
				/* 														Test 1: Identity multiply
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

		rst = 1'b1;
		@(posedge clk);
		rst = 1'b0;
		// LOADING PHASE
		// cycle 0
		in_north = '{0, 0, 0, 1'b1};
		@(posedge clk);
		// cycle 1
		in_north = '{0, 0, 1'b1, 0};
		@(posedge clk);
		// cycle 2
		in_north = '{0, 1'b1, 0, 0};
		@(posedge clk);
		// cycle 3
		in_north = '{1'b1, 0, 0, 0};
		@(posedge clk);

		//PROCESSING PHASE
		// cycle 4
		in_west[0] = 1'b1;
		@(posedge clk);
		// cycle 5
		in_west[0] = 0;
		in_west[1] = 0;
		@(posedge clk);
		// cycle 6
		in_west[0] = 0;
		in_west[1] = 1;
		in_west[2] = 0;
		@(posedge clk);
		// cycle 7
		in_west[0] = 0;
		in_west[1] = 0;
		in_west[2] = 0;
		in_west[3] = 0;
		@(posedge clk);
		// cycle 8
		in_west[1] = 0;
		in_west[2] = 1;
		in_west[3] = 0;
		@(posedge clk);
		// cycle 9
		in_west[2] = 0;
		in_west[3] = 0;
		@(posedge clk);
		// cycle 10
		in_west[3] = 1;
		@(posedge clk);
		// cycle 11. You have to clear inputs after use bc of design of in_west?? otherwise itll keep inputting a value of 1.
		in_west[3] = 0;
		@(posedge clk);

		repeat (5) @(posedge clk); // necessary for data to finish computing

		repeat (5) @(posedge clk); // extra wait time

		/*				
		   																	Test 2 : All ones
	
		A =	{1 1 1 1
			 1 1 1 1
			 1 1 1 1
			 1 1 1 1}

		B =	{1 1 1 1
			 1 1 1 1
			 1 1 1 1
			 1 1 1 1} 

		C =	{4 4 4 4
			 4 4 4 4
			 4 4 4 4
			 4 4 4 4} */

		in_north = '{1'b1, 1'b1, 1'b1, 1'b1};
		@(posedge clk);
		// cycle 1
		in_north = '{1'b1, 1'b1, 1'b1, 1'b1};
		@(posedge clk);
		// cycle 2
		in_north = '{1'b1, 1'b1, 1'b1, 1'b1};
		@(posedge clk);
		// cycle 3
		in_north = '{1'b1, 1'b1, 1'b1, 1'b1};
		@(posedge clk);

		//PROCESSING PHASE
		// cycle 4
		in_west[0] = 1'b1;
		@(posedge clk);
		// cycle 5
		in_west[1] = 1;
		@(posedge clk);
		// cycle 6
		in_west[2] = 1;
		@(posedge clk);
		// cycle 7.  At this point, all in_west inputs are 1. have to start clearing them out.
		in_west[3] = 1;
		@(posedge clk);
		// cycle 8
		in_west[0] = 0;
		@(posedge clk);
		// cycle 9
		in_west[1] = 0;
		@(posedge clk);
		// cycle 10
		in_west[2] = 0;
		@(posedge clk);
		// cycle 11
		in_west[3] = 0;
		@(posedge clk);

		@(posedge clk);
		repeat (5) @(posedge clk); // necessary for data to finish computing

		repeat (5) @(posedge clk); // extra wait time



		$finish;
	end

	initial begin

		// not sure how to present data best
		// $monitor("Time %0t", $time);
	end
endmodule