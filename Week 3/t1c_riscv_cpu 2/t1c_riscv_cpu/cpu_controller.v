module cpu_controller (
	input clk_3125MHz, MemWrite,
	input [31:0] WriteData, DataAdr,
	output reg reset,
	output reg Ext_MemWrite,
	output reg [31:0] Ext_WriteData, Ext_DataAdr,
	output reg [4:0] node_1,node_2,node_3,node_4,node_5
);

initial begin
	reset = 1;
	Ext_MemWrite = 1;
	node_points[0] = 0;
	node_points[1] = 0;
	node_points[2] = 0;
	node_points[3] = 0;
	node_points[4] = 0;
	node_points[5] = 0;
	node_points[6] = 0;
	node_points[7] = 0;
	node_points[8] = 0;
	node_points[9] = 0;
	
end


reg [31:0] node_points[0:9];

//SP - Ext_DataAdr = 32'h02000000
//EP - Ext_DataAdr = 32'h02000004
//NODE_POINT - Ext_DataAdr = 32'h02000008
//CPU_DONE - Ext_DataAdr = 32'h0200000c

parameter IDLE = 3'b000, WRITE_SP = 3'b001, WRITE_EP = 3'b010, WRITE_NODE_POINT = 3'b011, WRITE_CPU_DONE = 3'b100, STOP = 3'b101;
reg [2:0] state_machine = IDLE;
reg [2:0] prev_state = IDLE;
reg [3:0] counter = 0;

always @(posedge clk_3125MHz) begin
	counter <= counter + 1'b1;
	case (state_machine)
		IDLE: begin
			Ext_MemWrite <= 0;
			Ext_DataAdr <= 32'h0;
			Ext_WriteData <= 0;
			if (counter == 10) begin
				counter <= 0;
				if (prev_state == IDLE) begin
					state_machine <= WRITE_SP;
				end
				else if (prev_state == WRITE_SP) begin
					state_machine <= WRITE_EP;
				end
				else if (prev_state == WRITE_EP) begin
					state_machine <= WRITE_NODE_POINT;
				end
				else if (prev_state == WRITE_NODE_POINT) begin
					state_machine <= WRITE_CPU_DONE;
				end
				else state_machine <= IDLE;
			end
		end
		WRITE_SP: begin
			prev_state <= WRITE_SP;
			Ext_MemWrite <= 1;
			Ext_DataAdr <= 32'h02000000;
			Ext_WriteData <= 8;
			if (counter == 10) begin
				counter <= 0;
				state_machine <= IDLE;
			end
		end
		WRITE_EP: begin
			prev_state <= WRITE_EP;
			Ext_MemWrite <= 1;
			Ext_DataAdr <= 32'h02000004;
			Ext_WriteData <= 11;
			if (counter == 10) begin
				counter <= 0;
				state_machine <= IDLE;
			end
		end
		WRITE_NODE_POINT: begin
			prev_state <= WRITE_NODE_POINT;
			Ext_MemWrite <= 1;
			Ext_DataAdr <= 32'h02000008;
			Ext_WriteData <= 0;
			if (counter == 10) begin
				counter <= 0;
				state_machine <= IDLE;
			end
		end
		WRITE_CPU_DONE: begin
			prev_state <= WRITE_CPU_DONE;
			Ext_MemWrite <= 1;
			Ext_DataAdr <= 32'h0200000c;
			Ext_WriteData <= 0;
			if (counter == 10) begin
				counter <= 0;
				state_machine <= STOP;
			end
		end
		STOP: begin
		   Ext_MemWrite <= 0;
		   reset <= 0;
		end
	endcase
end

reg [3:0] i = 0;

//reg [4:0] node_1 = 0,node_2 = 0,node_3 = 0,node_4 = 0,node_5 = 0;

always @(posedge clk_3125MHz) begin
	if (MemWrite && !reset) begin
		if (DataAdr == 32'h02000008 && i < 5) begin
			node_points[i] <= WriteData;
			i <= i + 1;
		end
	end
	if (i == 5) begin
		node_1 <= node_points[0];
		node_2 <= node_points[1];
		node_3 <= node_points[2];
		node_4 <= node_points[3];
		node_5 <= node_points[4];
	end
end

endmodule