/*
* Module describing a 64-bit result buffer and the mux for controlling where
* in the buffer an adder's result is placed.
* 
* synchronous active high reset on posedge clk
*/
module result_buffer import calculator_pkg::*; (
    input logic clk_i,                              //clock signal
    input logic rst_i,                              //reset signal

    input logic [DATA_W-1 : 0] result_i,       //result from ALU
    input logic loc_sel,                            //mux control signal
    output logic [MEM_WORD_SIZE-1 : 0] buffer_o   //64-bit output of buffer
);

    //declare 64-bit buffer
    logic [MEM_WORD_SIZE-1 : 0] internal_buffer;

    //TODO: Write a sequential block to write the next values into the buffer.
    always_ff @(posedge clk_i) begin
        // COMMENTED CODE IS FOR INTERNAL BUFFER SEMANTICS
        if (rst_i) begin
            // internal_buffer <= '0;
            buffer_o <= '0;
        end else begin
            if (loc_sel) begin  // loc_sel = 1, put in upper half
                
                // internal_buffer [MEM_WORD_SIZE - 1 : MEM_WORD_SIZE - DATA_W] <= result_i;

                // buffer_o [MEM_WORD_SIZE - 1 : MEM_WORD_SIZE - DATA_W]  
                // <= internal_buffer [MEM_WORD_SIZE - 1 : MEM_WORD_SIZE - DATA_W];

                buffer_o [MEM_WORD_SIZE - 1 : MEM_WORD_SIZE - DATA_W] <= result_i;
            end else begin  // loc_sel = 0, put in lower half
                // internal_buffer [MEM_WORD_SIZE - DATA_W - 1 : 0] <= result_i [DATA_W - 1 : 0];

                // buffer_o [MEM_WORD_SIZE - DATA_W - 1 : 0] 
                //     <= internal_buffer [MEM_WORD_SIZE - DATA_W - 1 : 0];
                
                buffer_o [MEM_WORD_SIZE - DATA_W - 1 : 0] <= result_i;
            end
        end
    end

endmodule