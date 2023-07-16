//Asynchronous Counter
module counter(o, c, r);
  input c, r;
  output reg [3:0]o;
  always@(posedge c, posedge r)
    begin
      if(r)
        o <= 0;
      else
        o <=  o + 1'b1;
    end
endmodule


//TB
module tb;
  counter ss(o, c, r);
  logic c, r;
  logic [3:0]o;
  initial
    begin
      c = 1'b0;
      r = 1'b0;
      #1;
      r = 1'b1;
      #3 r = 1'b0;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  always #5 c = ~c;
endmodule
