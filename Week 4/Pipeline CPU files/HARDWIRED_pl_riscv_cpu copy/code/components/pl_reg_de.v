
module pl_reg_de (
    input clk, clr, RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD, Jalr, auiD,
    input [1:0] ResultSrcD,
    input [2:0] funct3D,
    input [3:0] ALUControlD,
    input [4:0] Rs1D, Rs2D, RdD,
    input [19:0] lui_auiD,
    input [31:0] rd_data1D, rd_data2D, PCD, ImmExtD, PCPlus4D,
    output reg RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE, JalrE, auiE,
    output reg [1:0] ResultSrcE,
    output reg [2:0] funct3E,
    output reg [3:0] ALUControlE,
    output reg [4:0] Rs1E, Rs2E, RdE,
    output reg [19:0] lui_auiE,
    output reg [31:0] rd_data1E, rd_data2E, PCE, ImmExtE, PCPlus4E
);

initial begin
    RegWriteE = 0; MemWriteE = 0; JumpE = 0; BranchE = 0; ALUSrcE = 0; JalrE = 0; auiE = 0;
    ResultSrcE = 0;
    funct3E = 0;
    ALUControlE = 0; 
    Rs1E = 0; Rs2E = 0; RdE = 0;
    lui_auiE = 0;
    rd_data1E = 0; rd_data2E = 0; PCE = 0; ImmExtE = 0; PCPlus4E = 0;
end

always @(posedge clk) begin
    if (clr) begin
        RegWriteE <= 0; MemWriteE <= 0; JumpE <= 0; BranchE <= 0; ALUSrcE <= 0; JalrE <= 0; auiE <= 0;
        ResultSrcE <= 0;
        funct3E <= 0;
        ALUControlE <= 0; 
        Rs1E <= 0; Rs2E <= 0; RdE <= 0;
        lui_auiE <= 0;
        rd_data1E <= 0; rd_data2E <= 0; PCE <= 0; ImmExtE <= 0; PCPlus4E <= 0;
    end else begin
        RegWriteE <= RegWriteD; MemWriteE <= MemWriteD; JumpE <= JumpD; BranchE <= BranchD; ALUSrcE <= ALUSrcD; JalrE <= Jalr; auiE <= auiD;
        ResultSrcE <= ResultSrcD;
        funct3E <= funct3D;
        ALUControlE <= ALUControlD;
        Rs1E <= Rs1D; Rs2E <= Rs2D; RdE <= RdD;
        lui_auiE <= lui_auiD;
        rd_data1E <= rd_data1D; rd_data2E <= rd_data2D; PCE <= PCD; ImmExtE <= ImmExtD; PCPlus4E <= PCPlus4D;
    end
    
end

endmodule