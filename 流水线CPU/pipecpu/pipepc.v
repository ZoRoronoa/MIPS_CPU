module pipepc(npc, wpc, clk, clrn, pc);

	input [31:0] npc;
	input        wpc, clrn, clk;

	output [31:0] pc;
	dffe32 program_counter(npc, clk, clrn, wpc, pc);

endmodule


