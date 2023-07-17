module ringcounter(q, r, c);
  input r, c;
  output reg [3:0]q;
  always@(posedge c)
    begin
      if(r)
        q <= 4'b1000;
      else
        begin
          q <= q >> 1;
          q[3] <= ~q[0];
        end
    end
endmodule


//TB
module tb;
  logic r, c;
  logic [3:0]q;
  ringcounter ss(q, r, c);
  
  initial
    begin
      c = 1'b0;
      r= 1'b1;
      @(negedge c)
      r = 1'b0;
    end
  always #5 c = ~c;
 
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
