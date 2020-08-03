// `include "ctrl_encode_def.v"


module CTRLUNIT(OpCode, FunctCode, Zero, 
            ALUToASel, ALUToBSel,ALUOpertion,
            EXTSel, NPCSel,
            MemWrite, 
            RegWrite, RegWriAddSel, RegWriDatSel,
            Load, Store
            );
            
   input  [5:0] OpCode;         // 操作码
   input  [5:0] FunctCode;      // 功能码
   input        Zero;           // 零标志位

   output  reg       ALUToASel;      // 操作数A选择
   output  reg       ALUToBSel;      // 操作数B选择
   output  reg [3:0] ALUOpertion;    // 操作功能选择
   output  reg       EXTSel;         // 立即数拓展选择
   output  reg [1:0] NPCSel;         // 下一个PC选择
   output  reg       MemWrite;       // 是否写存储器
   output  reg       RegWrite;       // 是否写寄存器
   output  reg [1:0] RegWriAddSel;   // 写寄存器地址选择
   output  reg [1:0] RegWriDatSel;   // 写寄存器数据选择
   output  reg [2:0] Load;
   output  reg [1:0] Store; 

   always@(OpCode or Zero or FunctCode)
    begin
      case (OpCode)
        6'b000000: begin // R型
          case(FunctCode)
            6'b100000: begin //add
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100010: begin //sub
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100100: begin //and
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0011_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100101: begin //or
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0100_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b101010: begin //slt
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0101_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b101011: begin //sltu
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0110_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100001: begin //addu
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100011: begin //subu
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b001000: begin //jr
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'bxxxx_11_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b001001: begin //jalr
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'bxxxx_11_00_10;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100111: begin //nor
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0111_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b000000: begin //sll
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b10001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1000_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b000010: begin //srl
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b10001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1001_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b000011: begin //sra
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b10001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1010_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b000100: begin //sllv
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1011_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b000110: begin //srlv
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1100_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            6'b100110: begin //xor
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1110_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
	          6'b000111: begin //srav
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00001;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1111_00_00_00;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
          endcase
        end
        //I 型
        6'b001000: begin //addi
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_00;
          {Load[2:0], Store[1:0]} = 5'bxxx_xx;
        end
        6'b001101: begin //ori
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0100_00_01_00;
          {Load[2:0], Store[1:0]} = 5'bxxx_xx;
        end
        6'b100011: begin //lw
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_01;
          {Load[2:0], Store[1:0]} = 5'b000_xx;
        end
        6'b101011: begin //sw
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01110;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_xx_xx;
          {Load[2:0], Store[1:0]} = 5'bxxx_00;
        end
  
        6'b000100: begin //beq
          case(Zero)
            1'b0: begin
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00x00;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_00_xx_xx;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            1'b1: begin
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00x00;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_01_xx_xx;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
          endcase
        end
        6'b000101: begin //bne
          case(Zero)
            1'b0: begin
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00x00;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_01_xx_xx;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
            1'b1: begin
              {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b00x00;
              {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0010_00_xx_xx;
              {Load[2:0], Store[1:0]} = 5'bxxx_xx;
            end
          endcase
        end
        6'b001010: begin //slti
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0101_00_01_00;
          {Load[2:0], Store[1:0]} = 5'bxxx_xx;
        end
        6'b001111: begin //lui
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b1101_00_01_00;
          {Load[2:0], Store[1:0]} = 5'bxxx_xx;
        end
        6'b001100: begin //andi
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0011_00_01_00;
          {Load[2:0], Store[1:0]} = 5'bxxx_xx;
        end
        6'b100000: begin //lb
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_01;
          {Load[2:0], Store[1:0]} = 5'b001_xx;
        end
        6'b100100: begin //lbu
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_01;
          {Load[2:0], Store[1:0]} = 5'b010_xx;
        end
        6'b100001: begin //lh
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_01;
          {Load[2:0], Store[1:0]} = 5'b011_xx;
        end
        6'b100101: begin //lhu
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01101;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_01_01;
          {Load[2:0], Store[1:0]} = 5'b100_xx;
        end
        6'b101000: begin //sb
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01110;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_xx_xx;
          {Load[2:0], Store[1:0]} = 5'bxxx_01;
        end
        6'b101001: begin //sh
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'b01110;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'b0001_00_xx_xx;
          {Load[2:0], Store[1:0]} = 5'bxxx_10;
        end

        //J 型
        6'b000010: begin //j
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'bxx000;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'bxxxx_10_xx_xx;
        end
        6'b000011: begin //jal
          {ALUToASel, ALUToBSel, EXTSel, MemWrite, RegWrite} = 5'bxx001;
          {ALUOpertion[3:0], NPCSel[1:0], RegWriAddSel[1:0], RegWriDatSel[1:0]} = 10'bxxxx_10_10_10;
        end
      endcase
    end

endmodule

