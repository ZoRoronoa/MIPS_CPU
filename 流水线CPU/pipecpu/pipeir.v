
module pipeir(pc4, inst, wir, clk, clrn, dpc4, dinst);

	input [31:0] pc4,  inst;   //输入要保存的信号 pc4和inst
	input        wir, clk, clrn;

	output [31:0] dpc4, dinst;  //pc4转为dpc4, inst转为dinst

	dffe32 pc_plus4(pc4, clk, clrn, wir, dpc4);
	dffe32 instruction (inst, clk, clrn, wir, dinst);

endmodule

