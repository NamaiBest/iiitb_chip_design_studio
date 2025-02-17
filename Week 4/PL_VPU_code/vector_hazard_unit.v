module vector_hazard_unit (
    input  [4:0]  rs1, rs2, rd, 
    input         we,
    output        stall
);

assign stall = (we && ((rs1 == rd) || (rs2 == rd))) ? 1'b1 : 1'b0;

endmodule
