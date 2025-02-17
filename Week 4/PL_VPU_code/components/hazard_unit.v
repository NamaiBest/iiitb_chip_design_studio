
module hazard_unit (
    input PCSrcE, RegWriteM, RegWriteW,
    input [1:0] ResultSrcE,
    input [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    output reg StallF, StallD, FlushD, FlushE,
    output reg [1:0] ForwardAE, ForwardBE
);

initial begin
    StallF = 0; StallD = 0; FlushD = 0; FlushE = 0;
    ForwardAE = 0; ForwardBE = 0;
end

always @(*) begin
    if(((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)) ForwardAE = 2'b10;
    else if(((Rs1E == RdW) & RegWriteW) & (Rs1E != 0)) ForwardAE = 2'b01;
    else ForwardAE = 2'b00;

    if(((Rs2E == RdM) & RegWriteM) & (Rs2E != 0)) ForwardBE = 2'b10;
    else if(((Rs2E == RdW) & RegWriteW) & (Rs2E != 0)) ForwardBE = 2'b01;
    else ForwardBE = 2'b00;

    StallF = ResultSrcE & ((Rs1D == RdE) || (Rs2D == RdE));
    StallD = ResultSrcE & ((Rs1D == RdE) || (Rs2D == RdE));

    FlushD = PCSrcE;
    FlushE = (ResultSrcE & ((Rs1D == RdE) || (Rs2D == RdE))) || PCSrcE;

end

endmodule