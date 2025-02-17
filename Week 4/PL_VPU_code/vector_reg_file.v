module vector_reg_file (
    input  wire        clk, reset,     // Clock and reset signals
    input  wire        we,             // Write enable
    input  wire [4:0]  read_reg1,      // Read address 1 (5-bit: 32 registers)
    input  wire [4:0]  read_reg2,      // Read address 2
    input  wire [4:0]  write_reg,      // Write address
    input  wire [31:0] write_data [0:3], // 4-element write data
    output reg  [31:0] read_data1 [0:3], // 4-element read data 1
    output reg  [31:0] read_data2 [0:3]  // 4-element read data 2
);

reg [31:0] vregs [0:31][0:3]; // 32 registers, each with 4 elements

integer i;

// Read operation (combinational)
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        read_data1[i] = vregs[read_reg1][i];
        read_data2[i] = vregs[read_reg2][i];
    end
end

// Write operation (synchronous)
always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            vregs[i][0] <= 0;
    end else if (we) begin
        for (i = 0; i < 4; i = i + 1)
            vregs[write_reg][i] <= write_data[i];
    end
end

endmodule
