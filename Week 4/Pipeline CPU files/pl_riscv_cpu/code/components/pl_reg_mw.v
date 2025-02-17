
module pl_reg_mw (
    input clk, RegWriteM, auiM,
    input [1:0] ResultSrcM,
    input [4:0] RdM,
    input [19:0] lui_auiM,
    input [31:0] ALUResultM, PCM, ReadDataM, WriteDataM, PCPlus4M,
    output reg RegWriteW, auiW,
    output reg [1:0] ResultSrcW,
    output reg [4:0] RdW,
    output reg [19:0] lui_auiW,
    output reg [31:0] ALUResultW, PCW, ReadDataW, WriteDataW, PCPlus4W
);

initial begin 
    RegWriteW = 0; auiW = 0; ResultSrcW = 0;
    RdW = 0; lui_auiW = 0; ALUResultW = 0; PCW = 0; ReadDataW = 0; WriteDataW = 0; PCPlus4W = 0;
end

always @(posedge clk) begin
    RegWriteW <= RegWriteM; 
    auiW <= auiM;
    ResultSrcW <= ResultSrcM;
    RdW <= RdM; 
    lui_auiW <= lui_auiM;
    ALUResultW <= ALUResultM; PCW <= PCM; ReadDataW <= ReadDataM; WriteDataW <= WriteDataM; PCPlus4W <= PCPlus4M;
end

endmodule