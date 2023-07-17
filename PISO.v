module piso(m, r, o, i, c);
  input m, r, c;    //m=0:load, m=1:shift
  input [3:0]i;
  output reg o;
  reg [3:0]q;
  reg si;
  always@(posedge c)
    begin
      if(r)
        begin
          q <= 0;
          o <= 0;
        end
      else if(~m)
         q <= i;
      else if(m)
        begin
          o <= q[3];
          q[3] <= q[2];
          q[2] <= q[1];
          q[1] <= q[0];
        end
    end
endmodule


//TB
module tb;
  piso ss(m, r, o, i, c);
  logic [3:0]i;
  logic o, m, r, c; 
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      r = 1'b1;
      #6 r = 1'b0;
      @(negedge c)
      m = 1'b0;
      i = 4'b1101;
      @(negedge c)
      m = 1'b1;
     
    end
  always #5 c = ~c;
endmodule
