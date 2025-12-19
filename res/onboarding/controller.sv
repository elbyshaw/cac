module controller import calculator_pkg::*;(
  	input  logic              clk_i,
    input  logic              rst_i,
  
  	// Memory Access
    input  logic [ADDR_W-1:0] read_start_addr,
    input  logic [ADDR_W-1:0] read_end_addr,
    input  logic [ADDR_W-1:0] write_start_addr,
    input  logic [ADDR_W-1:0] write_end_addr,
  
  	// Control
    output logic write,
    output logic [ADDR_W-1:0] w_addr,
    output logic [MEM_WORD_SIZE-1:0] w_data,

    output logic read,
    output logic [ADDR_W-1:0] r_addr,
    input  logic [MEM_WORD_SIZE-1:0] r_data,

  	// Buffer Control (1 = upper, 0, = lower)
    output logic              buffer_control,
  
  	// These go into adder
  	output logic [DATA_W-1:0]       op_a,
    output logic [DATA_W-1:0]       op_b,
  
    input  logic [MEM_WORD_SIZE-1:0]       buff_result
); 

	//TODO: Write your controller state machine as you see fit. 
	//HINT: See "6.2 Two Always BLock FSM coding style" from refmaterials/1_fsm_in_systemVerilog.pdf
	// This serves as a good starting point, but you might find it more intuitive to add more than two always blocks.

	//See calculator_pkg.sv for state_t enum definition
  	state_t state, next;

	//State reg, other registers as needed
	always_ff @(posedge clk_i) begin
		if (rst_i) begin
			state <= S_IDLE;
			r_addr <= read_start_addr; // reset addresses on reset
			w_addr <= write_start_addr;
			buffer_control <= 1'b1; // BUG?: set to 1 for when it gets inverted in first read
		end else begin
			state <= next;
		end
	end

	always_ff @(posedge clk_i) begin
		case (state)
			S_IDLE: begin
				r_addr <= r_addr;
				w_addr <= w_addr;
				buffer_control <= buffer_control;
			end

			S_READ: begin
				r_addr <= r_addr + 1'b1; // BUG?: starts one address ahead?
				w_addr <= w_addr;
				if (buffer_control == '0) begin
					buffer_control <= 1'b1;
				end else begin
					buffer_control <= '0;
				end
			end

			S_ADD: begin
				r_addr <= r_addr;
				w_addr <= w_addr;
				buffer_control <= buffer_control;
			end

			S_WRITE: begin
				r_addr <= r_addr;
				w_addr <= w_addr + 1'b1; // BUG?: starts one address ahead?
				buffer_control <= buffer_control;
			end

			S_END: begin
				r_addr <= r_addr;
				w_addr <= w_addr;
				buffer_control <= buffer_control;
			end
		endcase
	end
	
	//Next state logic, outputs
	always_comb begin
		case (state)
			S_IDLE: begin
				next = S_READ;
			end

			S_READ: begin
				read = '0;	// reading 
				// r_addr = ; 	// defined in always_ff block
				write = 1'b1;	// not writing
				// w_addr = w_addr; 	// defined in always_ff block
				w_data = w_data;
				// buffer_control = ~buffer_control;
				op_a = r_data [MEM_WORD_SIZE - DATA_WIDTH - 1: DATA_WIDTH];
				op_b = r_data [DATA_WIDTH - 1 : 0];

				next = S_ADD;
			end

			S_ADD: begin
				read = 1'b1;	// not reading 
				// r_addr = ; 	// defined in always_ff block
				write = 1'b1;	// not writing
				// w_addr = w_addr; 	// defined in always_ff block
				w_data = w_data;
				// buffer_control = buffer_control
				op_a = op_a;
				op_b = op_b;

				if (buffer_control == '0) begin // after inversion; started as 0 (first add)
					next = S_READ;
				end else begin 
					next = S_WRITE;
				end
			end



			S_WRITE: begin
				read = 1'b1;	// not reading 
				// r_addr = ; 	// defined in always_ff block
				write = '0;	// writing
				// w_addr = w_addr; 	// defined in always_ff block
				w_data = buff_result;
				// buffer_control = buffer_control
				op_a = op_a;
				op_b = op_b;

				if (rst_i) begin
					next = S_IDLE;
				end else if (r_addr >= read_end_addr
						||	w_addr >= write_end_addr) begin
					next = S_END;
				end begin
					next = S_READ;
				end
			end

			S_END: begin
				next = S_END;
			end
		endcase
	end

endmodule
