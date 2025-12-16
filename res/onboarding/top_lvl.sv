/* 
 * This top_level module integrates the controller, memory, adder, and result buffer to form a complete calculator system.
 * It handles memory reads/writes, arithmetic operations, and result buffering.
 */
module top_lvl import calculator_pkg::*; (
    input  logic                 clk,
    input  logic                 rst,

    // Memory Config
    input  logic [ADDR_W-1:0]    read_start_addr,
    input  logic [ADDR_W-1:0]    read_end_addr,
    input  logic [ADDR_W-1:0]    write_start_addr,
    input  logic [ADDR_W-1:0]    write_end_addr
    
);

    //Any wires, combinational assigns, etc should go at the top for visibility
    logic read_active;
    logic [MEM_WORD_SIZE-1:0] read_data_wire;
    logic [ADDR_W-1:0] read_address_wire;

    logic write_active;
    logic [MEM_WORD_SIZE-1 : 0] write_data_wire
    logic [ADDR_W-1:0] write_address_wire;

    logic [DATA_W-1:0] op_a_wire;
    logic [DATA_W-1:0] op_b_wire;

    logic [DATA_W-1:0] SRAM_A_read_output;
    logic [DATA_W-1:0] SRAM_B_read_output;

    logic [DATA_W-1:0] SRAM_A_write_input;
    logic [DATA_W-1:0] SRAM_B_write_input;

    logic [DATA_W-1:0] adder_output_wire;
    logic [MEM_WORD_SIZE-1:0] buffer_output_wire;
    logic buffer_loc;

    always_comb  begin
      SRAM_A_write_input = write_data_wire [DATA_W - 1 : 0];
      SRAM_B_write_input = write_data_wire [MEM_WORD_SIZE - 1 : MEM_WORD_SIZE - DATA_W];
      read_data_wire = {SRAM_B_read_output, SRAM_A_read_output}
    end

    
   
    //TODO: Finish instantiation of your controller module
	controller u_ctrl (
    // input
    .clk_i  (clk), 
    .rst_i  (rst), 
    .read_start_addr  (read_start_addr), 
    .read_end_addr  (read_end_addr), 
    .write_start_addr  (write_start_addr), 
    .write_end_addr  (write_end_addr), 
    .r_data  (read_data_wire),
    .buff_result  (write_data_wire),

    // output
    .write  (write_active),
    .w_addr (write_address_wire),
    .w_data (write_data_wire),
    .read   (read_active),
    .r_addr (read_address_wire),
    .buffer_control (buffer_loc),
    .op_a (op_a_wire),
    .op_b (op_b_wire)
  );

    //TODO: Look at the sky130_sram_2kbyte_1rw1r_32x512_8 module and instantiate it using variables defined above.
    // Note: This module has two ports, port 0 for read and write and port 1 for read only. We are using port 0 writing and port 1 for reading in this design.    
    // we have provided all of the input ports of SRAM_A, which you will need to connect to calculator ports inside the parentheses. 
    // Your instantiation for SRAM_A will be similar to SRAM_B. 
  	/*
     * .clk0 : sram macro clock input. Connect to same clock as controller.sv. 
     * .csb0 : chip select, active low. Set low when you want to write. Refer to sky130_sram instantiation to see what value to use for both read and write operations in port 0.
     * .web0 : write enable, active low. Set low when you want to write.  Refer to sky130_sram instantiation to see what value to use for both read and write operations in port 0.
     * .wmask0 : write mask, used to select which bits to write. For this design, we will write all bits, so use 4'hF.
     * .addr0 : address to read/write
     * .din0 : data to write
     * .dout0 : data output from memory when performing a read. Will leave blank here because we are only writing to port 0. 
     * .clk1  : sram macro clock input for port 2. Connect to same clock as controller.sv. 
     * .csb1  : chip select, active low. Set low when you want to read. Since this second port can only be used to read, there is no write enable bit (web) 
     * .addr1 : address to read from. You will supply this value. 
     * .dout1 : data output from the SRAM macro port.
     */
  	
      sky130_sram_2kbyte_1rw1r_32x512_8 sram_A (
        .clk0   (clk),   // i think?
        .csb0   (write_active), // should be 0 on write
        .web0   (write_active), // should be 0 on write
        .wmask0 (4'hF), // four 1s
        .addr0  (write_address_wire), 
        .din0   (SRAM_A_write_input), 
        .dout0  (), // blank. not reading this port
        .clk1   (clk), 
        .csb1   (read_active), // should be 0 on read
        .addr1  (read_address_wire), 
        .dout1  (SRAM_A_read_output) 
    );

  
    //TODO: Instantiate the second SRAM for the upper half of the memory.
    sky130_sram_2kbyte_1rw1r_32x512_8 sram_B (
        .clk0   (clk),   // i think?
        .csb0   (write_active), // should be 0 on write
        .web0   (write_active), // should be 0 on write
        .wmask0 (4'hF), // four 1s
        .addr0  (write_address_wire), 
        .din0   (SRAM_B_write_input), 
        .dout0  (), // blank. not reading this port
        .clk1   (clk), 
        .csb1   (read_active), // should be 0 on read
        .addr1  (read_address_wire), 
        .dout1  (SRAM_B_read_output) 
    );
  	
  	//TODO: Finish instantiation of your adder module
    adder32 u_adder (
      .a_i (op_a_wire),
      .b_i (op_b_wire),
      .sum_o (adder_output_wire)
    );
 
    //TODO: Finish instantiation of your result buffer
    result_buffer u_resbuf (
      .clk_i (clk),
      .rst_i (rst),
      .result_i (adder_output_wire)
      .loc_sel (buffer_loc),
      .buffer_o (buffer_output_wire)
    );

endmodule
