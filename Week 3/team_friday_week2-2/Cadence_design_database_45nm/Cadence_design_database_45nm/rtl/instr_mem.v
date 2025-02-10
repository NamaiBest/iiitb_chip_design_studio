module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
    input  wire [ADDR_WIDTH-1:0] instr_addr,
    output reg  [DATA_WIDTH-1:0] instr
);

    // Declare memory array
    reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];

    // Memory initialization is not done here (handled externally in synthesis)
    // Synthesis tools like Genus will treat this as an uninitialized Block RAM.

    // Read operation
    always @(*) begin
        instr = instr_ram[instr_addr[31:2]];
    end

endmodule




