module vector_branching_unit (
    input  [31:0] vrs1, vrs2,
    input  [2:0]  funct3,
    output        branch_taken
);

assign branch_taken = (funct3 == 3'b000) ? (vrs1 == vrs2) :
                      (funct3 == 3'b001) ? (vrs1 > vrs2)  :
                      (funct3 == 3'b010) ? (vrs1 < vrs2)  : 0;

endmodule
