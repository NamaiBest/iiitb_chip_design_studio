module vector_pipeline (
    input         clk, reset,
    input  [31:0] in_data,
    output [31:0] out_data
);

reg [31:0] pipeline_reg;

always @(posedge clk or posedge reset) begin
    if (reset)
        pipeline_reg <= 0;
    else
        pipeline_reg <= in_data;
end

assign out_data = pipeline_reg;

endmodule
