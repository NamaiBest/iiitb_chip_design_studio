module vector_decoder (
    input  wire [6:0]  opcode,     // Opcode field from instruction
    input  wire [2:0]  funct3,     // Function field (for operation type)
    input  wire [4:0]  rs1, rs2, rd, // Source and destination register addresses
    output reg         v_alu_en,   // Enable vector ALU
    output reg  [1:0]  v_alu_op,   // Vector ALU operation (00: vadd, 01: vmul)
    output reg         v_we,       // Vector Register File Write Enable
    output reg  [4:0]  v_rs1, v_rs2, v_rd // Vector register addresses
);

always @(*) begin
    // Default values (NOP operation)
    v_alu_en = 0;
    v_alu_op = 2'b00;
    v_we     = 0;
    v_rs1    = 5'b00000;
    v_rs2    = 5'b00000;
    v_rd     = 5'b00000;

    case (opcode)
        7'b1010000: begin // Vector ADD (vadd)
            v_alu_en = 1;
            v_alu_op = 2'b00; // vadd
            v_we     = 1;
            v_rs1    = rs1;
            v_rs2    = rs2;
            v_rd     = rd;
        end
        
        7'b1010001: begin // Vector MUL (vmul)
            v_alu_en = 1;
            v_alu_op = 2'b01; // vmul
            v_we     = 1;
            v_rs1    = rs1;
            v_rs2    = rs2;
            v_rd     = rd;
        end
        
        default: begin
            v_alu_en = 0;
            v_we     = 0;
        end
    endcase
end

endmodule
