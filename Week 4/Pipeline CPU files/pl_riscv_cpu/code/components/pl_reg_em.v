
module pl_reg_em (
    input clk, RegWriteE, MemWriteE, auiE,
    input [1:0] ResultSrcE,
    input [2:0] funct3E,
    input [4:0] RdE,
    input [19:0] lui_auiE,
    input [31:0] WriteDataE, ALUResult, PCE, PCPlus4E,
    output reg RegWriteM, MemWriteM, auiM,
    output reg [1:0] ResultSrcM,
    output reg [2:0] funct3M,
    output reg [4:0] RdM,
    output reg [19:0] lui_auiM,
    output reg [31:0] WriteDataM, ALUResultM, PCM, PCPlus4M
);

initial begin
    RegWriteM = 0; MemWriteM = 0; auiM = 0; ResultSrcM = 0; funct3M = 0; RdM = 0; lui_auiM = 0;
    WriteDataM = 0; ALUResultM = 0; PCM = 0; PCPlus4M = 0;
end

always @(posedge clk) begin
    RegWriteM <= RegWriteE; MemWriteM <= MemWriteE; auiM <= auiE;
    ResultSrcM <= ResultSrcE;
    funct3M <= funct3E;
    RdM <= RdE;
    lui_auiM <= lui_auiE;
    WriteDataM <= WriteDataE; ALUResultM <= ALUResult; PCM <= PCE; PCPlus4M <= PCPlus4E;
end

endmodule