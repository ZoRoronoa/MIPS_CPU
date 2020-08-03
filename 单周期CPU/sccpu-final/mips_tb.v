

// testbench for simulation
module mips_tb();
    
   reg  clk, rstn;   
   MIPS mips(
      .clk(clk), .rstn(rstn)
   );

  	
   
   initial begin
      
      $readmemh( "E:\CPU\\SINGLECPU6\\extendedtest.dat" , mips.instrmemory.rom); // load instructions into instruction memory
      
      clk = 1;
      rstn = 1;
      #5 ;
      rstn = 0;
      #20 ;
      rstn = 1;
      
   end
   
    always begin
    #(50) clk = ~clk;
	   
  if (clk == 1'b1) begin
    $display("pc   :\t %h", mips.PC);
    $display("instr:\t %h", mips.instr);
    if (mips.PC == 32'h00000128) begin
	$stop;
    end
 
  end
  
  end //end always
   
endmodule
