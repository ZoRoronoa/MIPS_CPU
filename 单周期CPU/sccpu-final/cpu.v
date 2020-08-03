module CPU( clk, rst, instr, MemRedData, PC, MemWrite, aluout, writedata, Load, Store);
         
   input      clk;
   input      rst;
   
   input [31:0]  instr;
   input [31:0]  MemRedData;  // 存储器读出的数据
   
   output [31:0] PC;        // 
   output        MemWrite;  // 存储器写信号
   output [31:0] aluout;    // ALU output
   output [31:0] writedata; // 存储器写数据
   output [2: 0] Load;
   output [1: 0] Store;

   //input  [4:0] reg_sel;    // register selection (for debug use)
   //output [31:0] reg_data;  // selected register data (for debug use)

   //指令数据
   wire [4:0]  rs;          // rs
   wire [4:0]  rt;          // rt
   wire [4:0]  rd;          // rd
   wire [5:0]  OpCode;      // 操作码
   wire [5:0]  FunctCode;   // 功能码
   wire [31:0] shamt;       // 移位大小
   wire [15:0] Imm16;       // 16位立即数
   wire [25:0] Imm26;       // 26位立即数
   wire [31:0] Imm32;       // 32位立即数   

   assign OpCode = instr[31:26]; 
   assign FunctCode = instr[5:0];
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign shamt = {27'b0, instr[10:6]};
   assign Imm16 = instr[15:0];
   assign Imm26 = instr[25:0];

   // 控制信号
   wire        RegWrite;     // 寄存器写信号
   wire        EXTSel;       // 拓展信号
   wire [3:0]  ALUOpertion;  // ALU
   wire [1:0]  NPCSel;       // NPC选择信号
   wire [1:0]  RegWriDatSel; // 写寄存器数据选择
   wire [1:0]  RegWriAddSel; // 写寄存器地址选择
   wire        ALUToASel;    // 操作数A选择
   wire        Zero;     
 
   // 选择数据
   wire [31:0] NPC;         // Next PC
   wire [4:0]  RegAdd;      // 写寄存器的地址
   wire [31:0] RegWriData;  // 写寄存器的数据
   wire [31:0] RsData;      // 寄存器Rs中的数据
   wire [31:0] A;           // 第一个操作数A
   wire [31:0] B;           // 第二个操作数B
   

   
   // 控制单元实例化
   CTRLUNIT ctrlunit ( 
      .OpCode(OpCode), .FunctCode(FunctCode), .Zero(Zero),
      .ALUToASel(ALUToASel), .ALUToBSel(ALUToBSel), .ALUOpertion(ALUOpertion),
      .EXTSel(EXTSel),  .NPCSel(NPCSel),
      .MemWrite(MemWrite),
      .RegWrite(RegWrite),.RegWriAddSel(RegWriAddSel), .RegWriDatSel(RegWriDatSel),
      .Load(Load), .Store(Store)
   );
   
   // PC实例化
   PC pc (
      .clk(clk), .rst(rst), .NPC(NPC), .PC(PC)
   ); 
   
   // NPC实例化
   NPC npc ( 
      .PC(PC), .NPCOp(NPCSel),.PCJR(RsData), .IMM(Imm26), .NPC(NPC)
   );
   
   // 寄存器组实例化
   RF registerfile (
      .clk(clk), .rst(rst), .RFWr(RegWrite),
      .A1(rs), .A2(rt), .RegAdd(RegAdd),
      .RegWriData(RegWriData),
      .RD1(RsData), .RD2(writedata)
      //.reg_sel(reg_sel),
      //.reg_data(reg_data)
   );
   
   // 选择写进寄存器的地址
   mux4 #(5) mux4_5 (
      .d0(rd), .d1(rt), .d2(5'b11111), .d3(5'b0), .s(RegWriAddSel), .y(RegAdd)
   );
   
   // 选择写进寄存器的数据
   mux4 #(32) mux4_32 (
      .d0(aluout), .d1(MemRedData), .d2(PC + 4), .d3(32'b0), .s(RegWriDatSel), .y(RegWriData)
   );

   // 选择符号拓展还是零拓展
   EXT ext ( 
      .Imm16(Imm16), .EXTOp(EXTSel), .Imm32(Imm32)
   );

   //选择第一个操作数
   mux2 #(32) mux2_32_a (
     .d0(RsData), .d1(shamt), .s(ALUToASel), .y(A)
   );  

   // 选择第二个操作数
   mux2 #(32) mux2_32_b (
      .d0(writedata), .d1(Imm32), .s(ALUToBSel), .y(B)
   );   
   
   // alu实例化
   ALU alu ( 
      .A(A), .B(B), .ALUOp(ALUOpertion), .C(aluout), .Zero(Zero)
   );

endmodule
