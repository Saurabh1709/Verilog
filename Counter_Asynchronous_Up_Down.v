//Asynchronous Counter
module counter(o, c, r, m);
  input c, r, m;
  output reg [3:0]o;
  always@(posedge c, posedge r)      //Down counter
    begin
      if(r && m)
        o <= 4'hf;
      else if(m)
        o<= o - 1'b1;            
    end
  always@(posedge c, posedge r)         //Up counter
    begin
      if(r && (~m))
        o <= 4'b0000;
      else if(~m)
        o<= o + 1'b1;
    end
endmodule


//TB
module tb;
  counter ss(o, c, r, m);
  logic c, r, m;
  logic [3:0]o;
  initial
    begin
      c = 1'b0;
      r = 1'b0;
      m = 1'b1;
      #1;
      r = 1'b1;
      #3 r = 1'b0;
      #50 m = 1'b0;
      r = 1'b1;
      #5 r = 1'b0;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  always #5 c = ~c;
endmodule
