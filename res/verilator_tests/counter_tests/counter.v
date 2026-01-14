module counter (
    input wire clk,       // Clock signal
    input wire reset,     // Active-high synchronous reset
    output reg [3:0] q    // 4-bit output register
);

    // This block triggers on every rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            // When reset is high, set the counter back to 0
            q <= 4'b0000;
        end else begin
            // Increment the counter by 1
            q <= q + 1;
        end
    end

endmodule
