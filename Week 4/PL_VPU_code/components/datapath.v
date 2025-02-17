
// datapath.v
module datapath (
    input         clk, reset,
    input [1:0]   ResultSrc,
    input         MemWrite,
    input         ALUSrc, RegWrite,
    input [1:0]   ImmSrc,
    input [3:0]   ALUControl,
    input         Branch, Jump, Jalr,
    output [31:0] PC,
    input  [31:0] Instr,
    output [31:0] InstrD,
    output [31:0] Mem_WrAddr, Mem_WrData,
    output        MemWriteM,
    output [2:0]  funct3M,
    input  [31:0] ReadData,
    output [31:0] Result,
    output [31:0] PCW, ALUResultW, WriteDataW
);

wire [31:0] PCNext, PCJalr, PCPlus4, PCTarget, AuiPC, lAuiPC;
wire [31:0] ImmExt, SrcAE, SrcBE, ALUResult;
wire Zero, TakeBranch, StallF, StallD, FlushD, FlushE;
wire [31:0] PCD, PCPlus4D;
wire [31:0] rd_data1D, rd_data2D;
wire RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE, JalrE, auiE;
wire [1:0] ResultSrcE, ForwardAE, ForwardBE;
wire [2:0] funct3E;
wire [3:0] ALUControlE;
wire [4:0] Rs1E, Rs2E, RdE;
wire [19:0] lui_auiE;
wire [31:0] rd_data1E, rd_data2E, PCE, ImmExtE, PCPlus4E, WriteDataE;
wire RegWriteM, auiM;
wire [1:0] ResultSrcM;
wire [4:0] RdM;
wire [19:0] lui_auiM;
wire [31:0] WriteDataM, ALUResultM, PCM, PCPlus4M;
wire RegWriteW, auiW;
wire [1:0] ResultSrcW;
wire [4:0] RdW;
wire [19:0] lui_auiW;
wire [31:0] ReadDataW, PCPlus4W;


wire PCSrcE = ((BranchE & TakeBranch) || JumpE || JalrE) ? 1'b1 : 1'b0;

// next PC logic
mux2 #(32)     pcmux(PCPlus4E, PCTarget, PCSrcE, PCNext); //error
mux2 #(32)     jalrmux (PCNext, ALUResult, JalrE, PCJalr);

// stallF - should be wired from hazard unit
// wire StallF = 0; // remove it after adding hazard unit.
reset_ff #(32) pcreg(clk, reset, StallF, PCJalr, PC);
adder          pcadd4(PC, 32'd4, PCPlus4);

// Pipeline Register 1 -> Fetch | Decode

// wire FlushD = 0; // remove it after adding hazard unit
// FlushD - should be wired from hazard unit
pl_reg_fd plfd (clk, StallD, FlushD, Instr, PC, PCPlus4,
              InstrD, PCD, PCPlus4D);

// pl_reg_fd plfd (clk, Instr, PC, PCPlus4,
//               InstrD, PCD, PCPlus4D);




// register file logic
reg_file       rf (clk, RegWriteW, InstrD[19:15], InstrD[24:20], RdW, Result, rd_data1D, rd_data2D);
imm_extend     ext (InstrD[31:7], ImmSrc, ImmExt);

// Pipeline Register 2 -> Decode | Execute


pl_reg_de plde (clk, FlushE, RegWrite, MemWrite, Jump, Branch, ALUSrc, Jalr, InstrD[5],
                ResultSrc, InstrD[14:12], ALUControl, InstrD[19:15], InstrD[24:20], InstrD[11:7], InstrD[31:12],
                rd_data1D, rd_data2D, PCD, ImmExt, PCPlus4D,
                RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE, JalrE, auiE,
                ResultSrcE, funct3E, ALUControlE, Rs1E, Rs2E, RdE, lui_auiE, rd_data1E,
                rd_data2E, PCE, ImmExtE, PCPlus4E);

adder          pcaddbranch(PCE, ImmExtE, PCTarget);
// ALU logic

//mux implementation after hazard unit
mux3 #(32)     srcA_rd1eMux(rd_data1E, Result, ALUResultM, ForwardAE, SrcAE);
mux3 #(32)     wrDE_rd2eMux(rd_data2E, Result, ALUResultM, ForwardBE, WriteDataE);

mux2 #(32)     srcbmux(WriteDataE, ImmExtE, ALUSrcE, SrcBE);
alu            alu (SrcAE, SrcBE, ALUControlE, ALUResult, Zero);

branching_unit bu (funct3E, Zero, ALUResult[31], TakeBranch);

// Pipeline Register 3 -> Execute | Memory


 pl_reg_em plem (clk, RegWriteE, MemWriteE, auiE, ResultSrcE, funct3E, RdE, lui_auiE, WriteDataE,
                ALUResult, PCE, PCPlus4E, RegWriteM, MemWriteM, auiM, ResultSrcM, funct3M, RdM, lui_auiM,
                WriteDataM, ALUResultM, PCM, PCPlus4M);

// Pipeline Register 4 -> Memory | Writeback



pl_reg_mw plmw (clk, RegWriteM, auiM,  ResultSrcM, RdM, lui_auiM, ALUResultM, PCM, ReadData, WriteDataM, PCPlus4M,
                RegWriteW, auiW, ResultSrcW, RdW, lui_auiW, ALUResultW, PCW, ReadDataW, WriteDataW, PCPlus4W);

adder #(32)    auipcadder ({lui_auiW, 12'b0}, PCW, AuiPC);
mux2 #(32)     lauipcmux (AuiPC, {lui_auiW, 12'b0}, auiW, lAuiPC);


// Result Source
mux4 #(32)     resultmux(ALUResultW, ReadDataW, PCPlus4W, lAuiPC, ResultSrcW, Result);

// hazard unit
hazard_unit hu (PCSrcE, RegWriteM, RegWriteW, ResultSrcE,
                InstrD[19:15], InstrD[24:20], Rs1E, Rs2E, RdE, RdM, RdW,
                StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

assign Mem_WrData = WriteDataM;
assign Mem_WrAddr = ALUResultM;

// eventually this statements will be removed while adding pipeline registers
// assign PCW = PC;
// assign ALUResultW = ALUResult;
// assign WriteDataW = WriteData;

endmodule
