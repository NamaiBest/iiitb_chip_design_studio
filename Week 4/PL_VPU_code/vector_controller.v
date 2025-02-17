module vector_controller (
    input  wire       clk, reset,      // Clock and reset signals
    input  wire [6:0] opcode,          // Opcode from instruction
    input  wire [4:0] rs1, rs2, rd,    // Register addresses
    input  wire       scalar_we,       // Scalar write enable
    output wire       is_vector_op,    // Vector operation flag
    output wire [3:0] alu_control,     // ALU control signals
    output wire       hazard_detected, // Hazard detection signal
    output reg        v_exec,          // Enable vector execution
    output reg        vector_stall     // Stall signal for pipeline
);

wire v_alu_en;
wire v_hazard;

// Vector Decoder
vector_decoder vdec (
    .opcode(opcode),
    .is_vector_op(is_vector_op),
    .alu_control(alu_control)
);

// Hazard Unit
vector_hazard_unit vhu (
    .rs1(rs1), .rs2(rs2), .rd(rd),
    .we(scalar_we),
    .stall(v_hazard)
);

assign hazard_detected = v_hazard;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        v_exec <= 0;
        vector_stall <= 0;
    end else begin
        if (is_vector_op) begin
            v_exec <= 1;
            vector_stall <= v_hazard;
        end else begin
            v_exec <= 0;
            vector_stall <= 0;
        end
    end
end

endmodule
