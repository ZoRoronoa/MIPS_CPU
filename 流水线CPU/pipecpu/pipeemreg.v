
module pipeemreg(ewreg, em2reg, ewmem, ealu, eb, ern, clk, clrn, mwreg, 
	             mm2reg, mwmem, malu, mb, mrn,emfhi, emflo, mmfhi, mmflo);

	input [31:0] ealu, eb;
	input [4:0]  ern;
	input        ewreg,  ewmem;
	input [1:0] em2reg;
	input        clk, clrn;
	input emfhi, emflo;

	output [31:0] malu, mb;
	output [4:0]  mrn;
	output        mwreg,  mwmem;
	output [1:0] mm2reg;
	output mmfhi, mmflo;
	reg [31:0]    malu, mb;
	reg [4:0]     mrn;
	reg           mwreg,  mwmem;
	reg mmflo, mmfhi;
	reg [1:0] mm2reg;

	always @(posedge clrn or posedge clk) begin
		if (clrn)begin
			mwreg <= 0;
			mm2reg <= 0;
			mwmem <= 0;
			malu <= 0;
			mb <= 0;
			mrn <= 0;
			mmflo <= 0;
			mmfhi <= 0;
		end
		else  begin

			mwreg <= ewreg;
			mm2reg <= em2reg;
			mwmem <= ewmem;
			malu <= ealu;
			mb <= eb;
			mrn <= ern;
			mmfhi <= emfhi;
			mmflo <= emflo;
		end
	end
endmodule


