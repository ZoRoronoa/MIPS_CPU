
module pipecpu(clk, rst, instr, readdata, PC, MemWrite, aluout, writedata, reg_sel, reg_data);
	
	/*
	指令的译码不能放在这里了
	我们这里对于流水线的实现是把指令存储器拉出来了
	 */

   /*
   接口如下：
   clk : 时钟
   rst : 复位
   instr : 指令， 来自指令存储器
   readdata : 数据 来自数据寄存器的输出
   PC: 地址， 连接到指令存储器中取值
   MemWrite: 写存储器信号
   aluout: 写存储器的地址

    */
   input      clk;          // clock
   input      rst;          // reset
   
   input [31:0]  instr;     // instruction
   input [31:0]  readdata;  // data from data memory
   
   output [31:0] PC;        // PC address
   output        MemWrite;  // memory write
   output [31:0] aluout;    // ALU output
   output [31:0] writedata; // data to data memory
   
   input  [4:0] reg_sel;    // register selection (for debug use)
   output [31:0] reg_data;  // selected register data (for debug use)



   /*
   此处的mwmem信号， 就是MemWrite信号， 
   malu是地址
   mb是 datain
   mmo是dataout 也就是 readdata

    */
   wire [31:0] dpc4, dinstr, da, db, dimm, ea, eb, eimm;
   wire [31:0] epc4,  wmo, wdi;
   wire       wpcir;        //写PC信号

   wire [1:0] pcsource;     //选择NPC
   wire [31:0] bpc;
   //wire [31:0] rpc;
   wire [31:0] jpc;
   wire [31:0] npc;
   wire [31:0] pc4;
   wire [31:0] dinst;

   wire [31:0]  walu;
   
   wire [31:0] ealu;
   wire [63:0] mult_alu;
   wire dwreg, dwmem, daluimm, dshift, djal, djalr;
   wire [1:0] dm2reg;
   wire dmfhi, dmflo, dmult;
   wire [31:0] hi;
   wire [31:0] lo;
   //wire [63:0] mult_alu;

   wire ewreg, ewmem, ealuimm, eshift, ejal, ejalr;
   wire [1:0] em2reg;
   wire emfhi, emflo, emult;
   wire mwreg, mwmem;
   wire [1:0] mm2reg;
   wire mmflo, mmfhi;
   wire wwreg;
   wire [1:0] wm2reg;
   wire wmflo, wmfhi;
   wire [4:0] daluc, ealuc;
   wire [4:0] drn, ern0, ern, mrn, wrn;
   wire f_flush;
   wire d_flush;


   /*
   pc和npc之间
   输入npc, wpcir, 得到pc的值作为整体的输出
    */
   pipepc prog_cnt(  
   				.npc(npc),               //input: npc
   				.wpc(wpcir),             //input: 写pc信号
   				.clk(clk),              
   				.clrn(rst), 
   				.pc(PC)                 //output: 输出PC的值
   				);

   /*
   pipeif逻辑单元， 通过pcsource选择新的npc值
   按照教材上的来说， 这一步应该完成取指的， 但是我们的指令存储器并不在这里， 而是
   直接令 dinst = instr
    */
   pipeif if_stage(
   		.pcsource(pcsource),         //input: 从pc4, bpc, rpc, jpc中选择
   		.ins(instr),                 //input: instr
   		.pc(PC),                     //input: PC
   		.bpc(bpc),                   //input: bpc
   		.rpc(da),                    //input: rpc
   		.jpc(jpc),                   //input: jpc
   		.npc(npc),                   //output: npc
   		.pc4(pc4),                   //output: pc4
   		.inst(dinst),
         .f_flush(f_flush),
         .d_flush(d_flush)           //output: dinst
   		);

   /*
   IF/ID级寄存器， 存储pc4和dinst的值, 
   输出的值为 dpc4和instr
    */
   pipeir inst_reg(
   		.pc4(pc4),                  //input: pc4
   		.inst(dinst),               //input: dinst
   		.wir(wpcir),                //input: 写PC信号
   		.clk(clk),
   		.clrn(rst),
   		.dpc4(dpc4),                //output: dpc4
   		.dinst(dinstr)               //output: dinstr
   	);


   pipeid id_stage(
         .mwreg(mwreg),                //Mem阶段的写寄存器信号
         .mrn(mrn),                    //Mem阶段的写rd or rt 信号
         .ern(ern),                    //
         .ewreg(ewreg),                //EXE阶段的写寄存器信号
         .em2reg(em2reg),              //EXE阶段的m2reg 信号
         .mm2reg(mm2reg),              //Mem阶段的m2reg 信号
         .dpc4(dpc4),                  //pc4
         .dinst(dinstr),               //来自IF/ID寄存器的指令
         .wrn(wrn),                    //写寄存器的地址
         .wdi(wdi),                    //写寄存器的数据
         .ealu(ealu),                  //
         .malu(aluout),                //注意！！ 此处的aluout即为要写存储器的地址
         .mmo(readdata),               //注意！！ 此处的readdata 就是从存储器中读出的数据
         .wwreg(wwreg),
         .clk(clk),
         .clrn(rst),
         .bpc(bpc),
         .jpc(jpc),
         .pcsource(pcsource),
         .nostall(wpcir),
         .wreg(dwreg),
         .m2reg(dm2reg),
         .wmem(dwmem),
         .aluc(daluc),
         .aluimm(daluimm),
         .a(da),
         .b(db),
         .imm(dimm),
         .rn(drn),
         .shift(dshift),
         .jal(djal),
         .jalr(djalr),
         .flush(f_flush),
         .d_flush(d_flush),
         .mult(dmult),
         .mfhi(dmfhi),
         .mflo(dmflo)
      );
      

      pipedereg de_reg(
            .dwreg(dwreg),
            .dm2reg(dm2reg),
            .dwmem(dwmem),
            .daluc(daluc),
            .daluimm(daluimm),
            .da(da),
            .db(db),
            .dimm(dimm),
            .drn(drn),
            .dshift(dshift),
            .djal(djal),
            .djalr(djalr),
            .dpc4(dpc4),
            .clk(clk),
            .clrn(rst),
            .ewreg(ewreg),
            .em2reg(em2reg),
            .ewmem(ewmem),
            .ealuc(ealuc),
            .ealuimm(ealuimm),
            .ea(ea),
            .eb(eb),
            .eimm(eimm),
            .ern(ern0),
            .eshift(eshift),
            .ejal(ejal),
            .ejalr(ejalr),
            .epc4(epc4),
            .dmult(dmult),
            .dmfhi(dmfhi),
            .dmflo(dmflo),
            .emult(emult),
            .emfhi(emfhi),
            .emflo(emflo)
            
         );


      pipeexe exe_stage(
            .ealuc(ealuc),
            .ealuimm(ealuimm),
            .ea(ea),
            .eb(eb),
            .eimm(eimm),
            .eshift(eshift),
            .ern0(ern0),
            .epc4(epc4),
            .ejal(ejal),
            .ejalr(ejalr),
            .ern(ern),
            .ealu(ealu),
            .mult_alu(mult_alu)
         );

      HILO hilo (
            .clk(clk),
            .rst(rst),
            .mfhi(wmfhi),
            .mflo(wmflo),
            .hi(hi),
            .lo(lo),
            .mult(emult),
            .C(mult_alu)
         );

      pipeemreg em_reg(
            .ewreg(ewreg),
            .em2reg(em2reg),
            .ewmem(ewmem),
            .ealu(ealu),
            .eb(eb),                   //eb->mb  要存储的寄存器数据
            .ern(ern),
            .clk(clk),
            .clrn(rst),
            .mwreg(mwreg),
            .mm2reg(mm2reg),
            .mwmem(MemWrite),
            .malu(aluout),                //注意！！ 此处的aluout即为写存储器地址
            .mb(writedata),               //注意！！ 此处的writedata即为要写存储器的数据
            .mrn(mrn),
            .emfhi(emfhi),
            .emflo(emflo),
            .mmfhi(mmfhi),
            .mmflo(mmflo)
         );
      


      pipemwreg mw_reg(
            .mwreg(mwreg),             //Mem阶段 写寄存器信号
            .mm2reg(mm2reg),           //Mem 传送到 reg的信号
            .mmo(readdata),            //注意！！ 此处的readdata 即为从存储器中读出的数据
            .malu(aluout),      //注意！！ 此处的aluout即为写存储器地址 ?? //malu 就是alu计算的值
            .mrn(mrn),               //rt or rd寄存器
            .clk(clk),
            .clrn(rst),
            .wwreg(wwreg),       //写寄存器信号
            .wm2reg(wm2reg),     //
            .wmo(wmo),           // 从存储器中读出来的数据， readdata过来的
            .walu(walu),         // malu->walu
            .wrn(wrn),            //mrn->wrn   写寄存器信号
            .mmfhi(mmfhi),
            .mmflo(mmflo),
            .wmfhi(wmfhi),
            .wmflo(wmflo)
         );


      mux4x32 wb_stage(
            .a0(walu),
            .a1(wmo),
            .a2(hi),
            .a3(lo),
            .s(wm2reg),          // 存储器到寄存器信号
            .y(wdi)
         ); 


endmodule






