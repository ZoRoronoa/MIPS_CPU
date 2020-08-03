
module pipeexe(ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4, ejal, ejalr, ern, ealu, mult_alu);

	input [31:0] ea, eb, eimm, epc4;
	input [4:0]  ern0;
	input [4:0]  ealuc;
	input        ealuimm, eshift, ejal, ejalr;

	output [31:0] ealu;
	output [4:0]  ern;
	output [63:0] mult_alu;
	wire [31:0] alua, alub, sa, ealu0, epc8;
	wire z;
	wire [63:0] mult_alu;
	//assign sa = {eimm[5:0], eimm[10:6]};           //计算得出移位的数量shamt
	assign sa = {27'b0, eimm[10:6]};
	//实在是不理解。。。 assign sa = {eimm[5:0], eimm[31:6]}
	//
	//cla32 ret_addr(epc4, 32'h4, 1'b0, epc8);       //这里使用的是pc+8， 也就是分支延迟槽?
	assign epc8 = epc4 + 4;
	mux2x32 alu_ina(ea, sa, eshift, alua);         //选择ALU的a输入端

	mux2x32 alu_inb(eb, eimm, ealuimm, alub);      //选择ALU的b输入端
	mux2x32 save_pc8(ealu0, epc4, ejal|ejalr, ealu);
	//assign ealu = ealu0;
	assign ern = ern0 | {5{ejal}};
	alu al_unit(alua, alub, ealuc, ealu0, z, mult_alu);

endmodule

