module lfsr(o, c, l);
  input c, l;
  output reg [3:0]o;
  always@(posedge c)
    begin
      if(l)
        o <= 4'hf;
      else
        begin
          o[2] <= o[3];
          o[1] <= o[2];
          o[0] <= o[1];
          o[3] <= (o[0]^o[1]);
        end
    end
endmodule


//TB
module tb;
  lfsr aa(o, c, l);
  logic c, l;
  logic [3:0]o;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      l = 1'b1;
      #6 l = 1'b0;
     
    end
  always #5 c = ~c;
endmodule
