
`include "ctrl_encode_def.v"
//`define ALU_NOP   5'b00000 
//`define ALU_ADD   5'b00001
//`define ALU_SUB   5'b00010 
//`define ALU_AND   5'b00011
//`define ALU_OR    5'b00100
//`define ALU_SLT   5'b00101
//`define ALU_SLTU  5'b00110
//`define ALU_NOR   5'b00111
//`define ALU_SLL   5'b01000
//`define ALU_SRL   5'b01001
//`define ALU_SRA   5'b01010
//`define ALU_SLLV  5'b01011
//`define ALU_SRLV  5'b01100
//`define ALU_SLL16 5'b01101
//`define ALU_XOR   5'b01110
//`define ALU_SRAV  5'b01111
//`define ALU_MULTI 5'b10000

module alu(A, B, ALUOp, C, Zero, D);


   input  signed [31:0] A, B;
   input         [4:0]  ALUOp;
   output signed [31:0] C;
   output signed [63:0] D;
   output Zero;
   
   reg [31:0] C;
   reg [63:0] D;
   integer    i;
       
   always @( * ) begin
      case ( ALUOp )
          `ALU_NOP:  C = A;                          // NOP
          `ALU_ADD:  C = A + B;                      // ADD
          `ALU_SUB:  C = A - B;                      // SUB
          `ALU_AND:  C = A & B;                      // AND/ANDI/ADDIU
          `ALU_OR:   C = A | B;                      // OR/ORI
          `ALU_SLT:  C = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI/SLTIU
          `ALU_SLTU: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;
	      `ALU_NOR:  C = ~(A | B);
        `ALU_XOR:  C = A ^ B;                      //xor
	      `ALU_SLL:  C = B << A;                     //sll
	      `ALU_SRL:  C = B >> A;                     //srl
	      `ALU_SRA:  C = B >>> A;                    //sra
	      `ALU_SLLV: C = B << A[4:0];                     //sllv
	      `ALU_SRLV: C = B >> A[4:0];                     //srlv
        `ALU_SRAV: C = B >>> A[4:0];                    //srav
	      `ALU_SLL16: C = B << 16;                   //lui
        `ALU_MULTI: D = A * B;                     //mutli
          default:   C = A;                          // Undefined
      endcase
   end // end always
   
   assign Zero = (C == 32'b0);

endmodule











