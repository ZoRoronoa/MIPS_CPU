module pipemwreg(mwreg, mm2reg, mmo, malu, mrn, clk, clrn,
				  wwreg, wm2reg, wmo, walu, wrn, mmfhi, mmflo, wmfhi, wmflo);

	input [31:0] mmo, malu;
	input [4:0] mrn;
	input       mwreg;
	input [1:0] mm2reg;
	input       clk, clrn;
	input mmfhi, mmflo;

	output [31:0] wmo, walu;
	output [4:0]  wrn;
	output        wwreg;
	output [1:0] wm2reg;
	output wmfhi, wmflo;
	reg [31:0] wmo, walu;
	reg [4:0]  wrn;
	reg        wwreg;
	reg [1:0] wm2reg;
	reg wmfhi, wmflo;
	always @(posedge clrn or posedge clk) begin
		if (clrn) begin
			wwreg <= 0;
			wm2reg <= 0;
			wmo <= 0;
			walu <= 0;
			wrn <= 0;
			wmfhi <= 0;
			wmflo <= 0;
		end
		else   begin
			wwreg <= mwreg;
			wm2reg <= mm2reg;
			wmo <= mmo;
			walu <= malu;
			wrn <= mrn;
			wmfhi <= mmfhi;
			wmflo <= mmflo;
		end
	end

endmodule


