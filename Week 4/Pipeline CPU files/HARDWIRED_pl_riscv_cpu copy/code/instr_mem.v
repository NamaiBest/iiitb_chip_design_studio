// instr_mem.v - synthesizable instruction memory (ROM)

module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32) (
    input  [ADDR_WIDTH-1:0] instr_addr,
    output reg [DATA_WIDTH-1:0] instr
);

always @(*) begin
    case (instr_addr[31:2])
        0:  instr = 32'h00100093;
        1:  instr = 32'h01000113;
        2:  instr = 32'hffd00193;
        3:  instr = 32'h00000213;
        4:  instr = 32'h00c18293;
        5:  instr = 32'h00211313;
        6:  instr = 32'hff012393;
        7:  instr = 32'hff013413;
        8:  instr = 32'h01214493;
        9:  instr = 32'h0031d513;
        10: instr = 32'h4031d593;
        11: instr = 32'h0031e613;
        12: instr = 32'h0031f693;
        13: instr = 32'h00110733;
        14: instr = 32'h401107b3;
        15: instr = 32'h00111833;
        16: instr = 32'h003128b3;
        17: instr = 32'h00313933;
        18: instr = 32'h001149b3;
        19: instr = 32'h00115a33;
        20: instr = 32'h40115ab3;
        21: instr = 32'h00116b33;
        22: instr = 32'h00117bb3;
        23: instr = 32'h02000c37;
        24: instr = 32'h02000c97;
        25: instr = 32'h001108a3;
        26: instr = 32'h00311b23;
        27: instr = 32'h00212c23;
        28: instr = 32'h02418d03;
        29: instr = 32'h02919d83;
        30: instr = 32'h02b1ae03;
        31: instr = 32'h0241ce83;
        32: instr = 32'h0291df03;
        33: instr = 32'h00000213;
        34: instr = 32'hffb00313;
        35: instr = 32'h00500393;
        36: instr = 32'h00120213;
        37: instr = 32'h00130313;
        38: instr = 32'hfe734ce3;
        39: instr = 32'h00600333;
        40: instr = 32'h00000213;
        41: instr = 32'hffb00413;
        42: instr = 32'h00500493;
        43: instr = 32'h00120213;
        44: instr = 32'hfff48493;
        45: instr = 32'hfe84dce3;
        46: instr = 32'h009004b3;
        47: instr = 32'h00000213;
        48: instr = 32'h00100513;
        49: instr = 32'h00500593;
        50: instr = 32'h00120213;
        51: instr = 32'h00150513;
        52: instr = 32'hfeb56ce3;
        53: instr = 32'h00a00533;
        54: instr = 32'h00000213;
        55: instr = 32'h00100613;
        56: instr = 32'h00500693;
        57: instr = 32'h00120213;
        58: instr = 32'hfff68693;
        59: instr = 32'hfec6fce3;
        60: instr = 32'h00d006b3;
        61: instr = 32'h00000213;
        62: instr = 32'h00500713;
        63: instr = 32'h00000793;
        64: instr = 32'h00120213;
        65: instr = 32'h00178793;
        66: instr = 32'hfee79ce3;
        67: instr = 32'h00f007b3;
        68: instr = 32'h00000213;
        69: instr = 32'h00200813;
        70: instr = 32'h00300893;
        71: instr = 32'h00120213;
        72: instr = 32'h00180813;
        73: instr = 32'hff180ce3;
        74: instr = 32'h01000833;
        75: instr = 32'h13400fe7;
        76: instr = 32'hfff00213;
        77: instr = 32'h01f00fb3;
        78: instr = 32'h0000026f;
        default: instr = 32'h00000000;
    endcase
end

endmodule