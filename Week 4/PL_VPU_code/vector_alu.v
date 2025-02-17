module vector_alu (
    input  wire        clk, reset,      // Clock and reset signals
    input  wire        venable,         // Enable signal for vector operations
    input  wire [6:0]  opcode,          // Opcode to identify vector operation
    input  wire [31:0] vsrc1 [0:3],     // First source vector (4 elements)
    input  wire [31:0] vsrc2 [0:3],     // Second source vector (4 elements)
    output reg  [31:0] vresult [0:3]    // Result vector (4 elements)
);

integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 4; i = i + 1) 
            vresult[i] <= 0;
    end else if (venable) begin  // Execute only when enabled
        case (opcode)
            7'b1010000: // vadd: Vector Addition
                for (i = 0; i < 4; i = i + 1)
                    vresult[i] <= vsrc1[i] + vsrc2[i];

            7'b1010001: // vmul: Vector Multiplication
                for (i = 0; i < 4; i = i + 1)
                    vresult[i] <= vsrc1[i] * vsrc2[i];

            7'b1010010: // vsub: Vector Subtraction
                for (i = 0; i < 4; i = i + 1)
                    vresult[i] <= vsrc1[i] - vsrc2[i];

            7'b1010011: // vmin: Element-wise Min
                for (i = 0; i < 4; i = i + 1)
                    vresult[i] <= (vsrc1[i] < vsrc2[i]) ? vsrc1[i] : vsrc2[i];

            default: // NOP (No Operation)
                for (i = 0; i < 4; i = i + 1)
                    vresult[i] <= vresult[i];
        endcase
    end
end

endmodule
