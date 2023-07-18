module gated_clk(cg, c, en);
  input en, c;
  output cg;
  wire tmp;
  assign tmp = (~c)?en:tmp;
  assign cg = c & tmp;
endmodule


//TB
module tb;
  logic cg, c, en;
  gated_clk aa(cg, c, en);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    
    begin
      en = 1'b0;
      c = 1'b0;
      #7 en = 1'b1;
     
      #52 en = 1'b0;
      
      
    end
  always #5 c = ~c;
 
endmodule
