module pl_riscv_cpu (
    input         clk, reset,
    input         Ext_MemWrite,
    input  [31:0] Ext_WriteData, Ext_DataAdr,
    output        MemWrite,
    output [31:0] WriteData, DataAdr, ReadData,
    output [31:0] PCW, Result, ALUResultW, WriteDataW
);

// Internal wires
wire [31:0] Instr, PC;
wire [31:0] DataAdr_rv32, WriteData_rv32;
wire [ 2:0] Store, funct3;
wire        MemWrite_rv32;

// Vector Processing Wires
wire        is_vector_op, vector_stall;
wire [31:0] vresult;

// Instantiate CPU Core
riscv_cpu rvcpu (
    .clk(clk), .reset(reset), 
    .PC(PC), .Instr(Instr), 
    .MemWriteM(MemWrite_rv32), .Mem_WrAddr(DataAdr_rv32),
    .Mem_WrData(WriteData_rv32), .ReadData(ReadData), 
    .Result(Result), .funct3M(funct3),
    .PCW(PCW), .ALUResultW(ALUResultW), .WriteDataW(WriteDataW)
);

// Instantiate Vector Processing Unit (VPU)
vpu vpu_core (
    .clk(clk), .reset(reset),
    .opcode(Instr[6:0]), .rs1(Instr[19:15]), .rs2(Instr[24:20]), .rd(Instr[11:7]),
    .scalar_data(WriteData_rv32), .scalar_we(MemWrite_rv32),
    .vresult(vresult), .vector_stall(vector_stall), .is_vector_op(is_vector_op)
);

// Shared Instruction & Data Memory
instr_mem instrmem (PC, Instr);
data_mem  datamem  (clk, MemWrite, Store, DataAdr, WriteData, ReadData);

// Control Logic for Shared Memory
assign Store      = (Ext_MemWrite && reset) ? 3'b010 : funct3;
assign MemWrite   = (Ext_MemWrite && reset) ? 1'b1 : MemWrite_rv32;
assign WriteData  = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr    = reset ? Ext_DataAdr : DataAdr_rv32;

// Program Counter Handling (Stall if Vector Operation)
assign PCW = vector_stall ? PCW : PC; 

endmodule
2