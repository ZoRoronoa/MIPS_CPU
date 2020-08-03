module pipeid(mwreg, mrn, ern, ewreg, em2reg, mm2reg, dpc4, dinst, wrn, wdi, ealu, malu, mmo, wwreg, clk, 
clrn, bpc, jpc, pcsource, nostall, wreg, m2reg, wmem, aluc, aluimm, a,b,imm, rn, shift, jal, jalr, flush, d_flush, mult, mfhi, mflo);


//module pipeid(mwreg, mrn, ern, ewreg, em2reg, mm2reg, dpc4, dinst, wrn, wdi, ealu, malu, mmo, wwreg, clk, 
//clrn, bpc, jpc, pcsource, nostall, wreg, m2reg, wmem, aluc, aluimm, a,b,imm, rn, shift, jal);//, flush, d_flush);
	input [31:0] dpc4, dinst, wdi, ealu, malu, mmo;  //dpc4来自上一级的pc4, dinst来自上一级的inst, 
													 //wdi是待写入寄存器的数据
													 //ealu, malu是是旁路的,mmo是？
	input [4:0]  ern, mrn, wrn;
	input        mwreg, ewreg, wwreg;//, em2reg, mm2reg, wwreg;
	input [1:0]  em2reg, mm2reg;
	input        clk, clrn;
	input 		 d_flush;

	output [31:0] bpc, jpc, a, b, imm;
	output [4:0]  rn;
	output [4:0]  aluc;
	output [1:0]  pcsource;
	output nostall, wreg, wmem, aluimm, shift, jal, jalr, mult, mfhi, mflo;
	output [1:0] m2reg;
	output flush;

	wire [5:0] op, func;
	wire [4:0] rs, rt, rd;
	wire [31:0] qa, qb, br_offset;
	wire [15:0] ext16;
	wire [1:0]  fwda, fwdb;
	wire        regrt, sext, rsrtequ,e;

	assign func = dinst[5:0];
	assign op = dinst[31:26];
	assign rs = dinst[25:21];
	assign rt = dinst[20:16];
	assign rd = dinst[15:11];
	assign jpc = {dpc4[31:28], dinst[25:0], 2'b00};


	pipeidcu cu(mwreg, mrn, ern, ewreg, em2reg, mm2reg, rsrtequ, func, op, rs, rt, wreg, m2reg, wmem, aluc,
		regrt, aluimm, fwda, fwdb, nostall, sext, pcsource, shift, jal, jalr, flush, d_flush, mult, mfhi, mflo);


	//pipeidcu cu(mwreg, mrn, ern, ewreg, em2reg, mm2reg, rsrtequ, func, op, rs, rt, wreg, m2reg, wmem, aluc,
	//	regrt, aluimm, fwda, fwdb, nostall, sext, pcsource, shift, jal);//, flush, d_flush);


	regfile rf(rs,rt, wdi, wrn, wwreg, ~clk, clrn, qa, qb);

	mux2x5 des_reg_no(rd, rt, regrt, rn);

	mux4x32 alu_a(qa, ealu, malu, mmo, fwda, a);
	mux4x32 alu_b(qb, ealu, malu, mmo, fwdb, b);

	assign rsrtequ = ~|(a^b);                    //提前判断beq和bne指令

	assign e = sext & dinst[15];

	assign ext16 = {16{e}};

	assign imm = {ext16, dinst[15:0]};

	assign br_offset = {imm[29:0], 2'b00};

	//cla32 br_addr(dpc4, br_offset, 1'b0, bpc);   //计算出bpc的值
	assign bpc = dpc4 + br_offset;
endmodule


