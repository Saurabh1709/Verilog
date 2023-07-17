module serialadder(s, c, a, b, clk, r);
  input a, b, r;
  input clk;
  output reg s;
  output c;
  reg c1, c2;
  assign c = c2;
  always@(posedge clk)
    begin
      if(r)
        begin
          s = 0;
          c1=0;
          c2= 0;
        end
    else
      {c2,s} = a + b + c1; 
    end
  always@(c)
    begin
      c1 <= c2;
    end
  
endmodule

//TB
module tb;
  logic s, c, clk, r;
  logic a, b;
  serialadder ss(s, c, a, b, clk, r);
  
  initial
    begin
      clk = 1'b0;
      r = 1'b1;
      #6
      r = 1'b0;
      for(int x=0; x<15; x++)
        begin
          a = $urandom_range(0, 1);
          b = $urandom_range(0, 1);
          #6;
        end
    end
    
  always #5 clk = ~clk;
 
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end

endmodule
