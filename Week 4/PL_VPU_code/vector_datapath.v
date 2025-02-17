module vector_datapath (
    input         clk, reset,
    input  [3:0]  alu_control,
    input  [31:0] vsrc1 [0:3], vsrc2 [0:3],
    output [31:0] vresult [0:3],
    input         hazard_detected,
    input         v_exec,
    input  [4:0]  rs1, rs2, rd,
    input  [31:0] scalar_data [0:3]
);

wire [31:0] mux_out [0:3];
wire branch_taken;

// Vector Register File
vector_reg_file vreg (
    .clk(clk), .reset(reset),
    .we(v_exec), .write_reg(rd), .read_reg1(rs1), .read_reg2(rs2),
    .write_data(scalar_data),  // Writing scalar data into vector registers (if needed)
    .read_data1(vsrc1), .read_data2(vsrc2)
);

// Vector ALU
vector_alu valu (
    .clk(clk), .reset(reset),
    .venable(v_exec),
    .opcode(alu_control), // Assuming alu_control contains the opcode
    .vsrc1(vsrc1), .vsrc2(vsrc2),
    .vresult(vresult)
);

// Vector Pipeline
vector_pipeline vpipe (
    .clk(clk), .reset(reset),
    .in_data(vresult[0]),
    .out_data(vresult[0])
);

// Vector Branch Unit
vector_branching_unit vbranch (
    .vrs1(vsrc1[0]), .vrs2(vsrc2[0]), // Assuming single element for branching
    .funct3(alu_control[2:0]), // Assuming funct3 is part of alu_control
    .branch_taken(branch_taken)
);

// Vector Muxes
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : muxes
        vector_mux2 vmux (
            .in0(vsrc1[i]), .in1(vsrc2[i]),
            .sel(branch_taken),
            .out(mux_out[i])
        );
    end
endgenerate

endmodule
