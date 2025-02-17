// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
    input  [2:0] funct3,
    output reg [1:0] ResultSrc,
    output reg       MemWrite, Branch, ALUSrc,
    output reg       RegWrite, Jump, Jalr,
    output reg [1:0] ImmSrc,
    output reg [1:0] ALUOp
);

always @(*) begin
    // Default values to avoid latches
    RegWrite = 0;
    ImmSrc = 2'b00;
    ALUSrc = 0;
    MemWrite = 0;
    ResultSrc = 2'b00;
    ALUOp = 2'b00;
    Jump = 0;
    Jalr = 0;
    Branch = 0;

    casez (op)
        7'b0000011: begin // lw
            RegWrite = 1;
            ImmSrc = 2'b00;
            ALUSrc = 1;
            ResultSrc = 2'b01;
        end
        7'b0100011: begin // sw
            ImmSrc = 2'b01;
            ALUSrc = 1;
            MemWrite = 1;
        end
        7'b0110011: begin // R–type
            RegWrite = 1;
            ALUOp = 2'b10;
        end
        7'b1100011: begin // branch
            ImmSrc = 2'b10;
            Branch = 1;
            ALUOp = 2'b01;
        end
        7'b0010011: begin // I–type ALU
            RegWrite = 1;
            ALUSrc = 1;
            ALUOp = 2'b10;
        end
        7'b1101111: begin // jal
            RegWrite = 1;
            ImmSrc = 2'b11;
            ResultSrc = 2'b10;
            Jump = 1;
        end
        7'b1100111: begin // jalr
            RegWrite = 1;
            ALUSrc = 1;
            ResultSrc = 2'b10;
            Jalr = 1;
        end
        7'b0?10111: begin // lui or auipc
            RegWrite = 1;
            ResultSrc = 2'b11;
        end
        default: begin
            // Default case to avoid latches
            RegWrite = 0;
            ImmSrc = 2'b00;
            ALUSrc = 0;
            MemWrite = 0;
            ResultSrc = 2'b00;
            ALUOp = 2'b00;
            Jump = 0;
            Jalr = 0;
            Branch = 0;
        end
    endcase
end

endmodule