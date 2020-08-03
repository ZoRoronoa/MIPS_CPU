
module pipedereg(dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm, drn, dshift, djal,djalr, dpc4, clk, clrn, 
                 ewreg,em2reg ,ewmem, ealuc, ealuimm, ea, eb, eimm, ern, eshift, ejal,ejalr, epc4,
                 dmult, dmfhi, dmflo, emult, emfhi, emflo);

	input [31:0] da, db, dimm, dpc4;
	input [4:0] drn;
	input [4:0]  daluc;
	input        dwreg, dwmem, daluimm, dshift, djal, djalr;
	input [1:0] dm2reg;
	input dmult, dmfhi, dmflo;
	input        clk, clrn;

	output [31:0] ea, eb, eimm, epc4;
	output [4:0]  ern;
	output [4:0]  ealuc;
	output        ewreg,  ewmem, ealuimm, eshift, ejal, ejalr;
	output [1:0]  em2reg;
	output emult, emfhi, emflo;
	reg [31:0]    ea, eb, eimm, epc4;
	reg [4:0]     ern;
	reg [4:0]     ealuc;

	reg	          ewreg, ewmem, ealuimm, eshift, ejal, ejalr;
	reg [1:0] em2reg;
	reg emult, emfhi, emflo;
	always @ (posedge clrn or posedge clk)begin
	if(clrn)
	begin
		ewreg <= 0;
		em2reg <= 0;
		ewmem <= 0;
		ealuc <= 0;
		ealuimm <= 0;
		ea <= 0;
		eb <= 0;
		eimm <= 0;
		ern <= 0;
		eshift <= 0;
		ejal <= 0;
		ejalr <= 0;
		epc4 <= 0;
		emult <= 0;
		emfhi <= 0;
		emflo <= 0;

	end else begin
		ewreg <= dwreg;
		em2reg <= dm2reg;
		ewmem <= dwmem;
		ealuc <= daluc;
		ealuimm <= daluimm;
		ea <= da;
		eb <= db;
		eimm <= dimm;
		ern <= drn;
		eshift <= dshift;
		ejal <= djal;
		ejalr <= djalr;
		epc4 <= dpc4;
		emult <= dmult;
		emfhi <= dmfhi;
		emflo <= dmflo;

	end
	end


endmodule

