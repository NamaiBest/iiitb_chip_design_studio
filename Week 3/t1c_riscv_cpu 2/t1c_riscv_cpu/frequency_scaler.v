module frequency_scaler(
    input clk_50M,
    output reg clk_3125MHz
);

reg [2:0] clk_counter = 0;

always @(negedge clk_50M) begin
    if (clk_counter == 7) clk_3125MHz = ~clk_3125MHz;
      clk_counter = clk_counter + 1'b1;
end

endmodule