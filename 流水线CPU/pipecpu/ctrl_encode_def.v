
// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10
`define NPC_JR      2'b11

// ALU control signal
//`define ALU_NOP   4'b0000 
//`define ALU_ADD   4'b0001
//`define ALU_SUB   4'b0010 
//`define ALU_AND   4'b0011
//`define ALU_OR    4'b0100
//`define ALU_SLT   4'b0101
//`define ALU_SLTU  4'b0110
//`define ALU_NOR   4'b0111
//`define ALU_SLL   4'b1000
//`define ALU_SRL   4'b1001
//`define ALU_SRA   4'b1010
//`define ALU_SLLV  4'b1011
//`define ALU_SRLV  4'b1100
//`define ALU_SLL16 4'b1101
//`define ALU_XOR   4'b1110
//`define ALU_SRAV  4'b1111

`define ALU_NOP   5'b00000 
`define ALU_ADD   5'b00001
`define ALU_SUB   5'b00010 
`define ALU_AND   5'b00011
`define ALU_OR    5'b00100
`define ALU_SLT   5'b00101
`define ALU_SLTU  5'b00110
`define ALU_NOR   5'b00111
`define ALU_SLL   5'b01000
`define ALU_SRL   5'b01001
`define ALU_SRA   5'b01010
`define ALU_SLLV  5'b01011
`define ALU_SRLV  5'b01100
`define ALU_SLL16 5'b01101
`define ALU_XOR   5'b01110
`define ALU_SRAV  5'b01111
`define ALU_MULTI 5'b10000