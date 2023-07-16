//DFF
module dff(q, c, r, d);
  input c, d, r;
  output reg q;
  always@(posedge c)
    begin
      if(r)
        q <= 1'b0;
      else
        q <= d;
    end
endmodule

//TB
module tb;
  dff ss(q, c, r, d);
  logic q, c, d, r;
  initial
    begin
      c = 1'b0;
      r = 1'b1;
      d = 1'b1;
      #8 
      r = 1'b0;
      @(negedge c)
      d = 1'b0;
      @(negedge c)
      d = 1'b1;
    end
  
  always #5 c = ~c;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
