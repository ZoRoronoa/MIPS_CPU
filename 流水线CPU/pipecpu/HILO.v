
module HILO (clk,rst,mfhi,mflo,hi,lo,mult,C);
 
   input clk,rst,mfhi,mflo,mult;
   input [63:0] C;
   output [31:0] hi,lo;

   reg [31:0] HI,LO;

always@(posedge clk or posedge rst)begin
   if(rst)begin
	HI = 0;
	LO = 0;
end
   else if(mult)begin
	HI = C[63:32];
	LO = C[31:0];
end
 
end

assign hi = (mfhi == 1) ? HI : 0;
assign lo = (mflo == 1) ? LO : 0;
endmodule
