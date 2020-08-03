module MIPS(clk, rstn);
   input          clk;
   input          rstn;

   
   wire [31:0]    instr;
   wire [31:0]    PC;
   wire           MemWrite;
   wire [31:0]    MemAdd, MemWriData, MemRedData;
   wire [2: 0]    Load;
   wire [1: 0]    Store;
   wire rst = ~rstn;
        
  // instantiation of single-cycle CPU   
   CPU cpu(
         .clk(clk),                 // input:  cpu clock
         .rst(rst),                 // input:  reset
         .instr(instr),             // input:  instruction
         .MemRedData(MemRedData),   // input:  data to cpu  
         .MemWrite(MemWrite),       // output: memory write signal
         .PC(PC),                   // output: PC
         .aluout(MemAdd),          // output: address from cpu to memory
         .writedata(MemWriData),        // output: data from cpu to memory
         .Load(Load),        // output: register data
         .Store(Store)
         );
         
  // instantiation of data memory  
   DM    datamemory(
         .clk(clk),           // input:  cpu clock
         .MemWrite(MemWrite),     // input:  ram write
         .MemAdd(MemAdd), // input:  ram address
         .MemWriData(MemWriData),        // input:  data to ram
         .Load(Load),
         .Store(Store),
         .MemRedData(MemRedData)       // output: data from ram
         );

  // instantiation of intruction memory (used for simulation)
   IM    instrmemory ( 
      .RegRedAdd(PC[8:2]),     // input:  rom address
      .RegRedData(instr)        // output: instruction
   );
        
endmodule


