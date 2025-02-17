module vpu (
    input         clk, reset, 
    input  [6:0]  opcode,      
    input  [4:0]  rs1, rs2, rd, 
    input  [31:0] scalar_data [0:3], 
    input         scalar_we,   
    output [31:0] vresult [0:3],
    output        vector_stall  
);

wire is_vector_op;
wire [3:0] alu_control;
wire [31:0] vsrc1 [0:3], vsrc2 [0:3];
wire hazard_detected;
wire v_exec;

// Vector Controller
vector_controller vctrl (
    .clk(clk), .reset(reset),
    .opcode(opcode),
    .rs1(rs1), .rs2(rs2), .rd(rd),
    .scalar_we(scalar_we),
    .is_vector_op(is_vector_op),
    .alu_control(alu_control),
    .hazard_detected(hazard_detected),
    .v_exec(v_exec),
    .vector_stall(vector_stall)
);

// Vector Datapath
vector_datapath vdp (
    .clk(clk), .reset(reset),
    .alu_control(alu_control),
    .vsrc1(vsrc1), .vsrc2(vsrc2),
    .vresult(vresult),
    .hazard_detected(hazard_detected),
    .v_exec(v_exec),
    .rs1(rs1), .rs2(rs2), .rd(rd),
    .scalar_data(scalar_data)
);

endmodule
