module fifo(o, i, r, w, c, rst, empty, full);
  input [3:0]i;
  output reg [3:0]o;
  input w, r, c, rst;
  output empty, full;
  reg [3:0]r_p, w_p;
  reg [3:0]mem[15:0];
  
  assign empty = (r_p == w_p)?1:0;
  assign full = (w_p + 1 == r_p)?1:0;
  
  always@(posedge c)
    begin
      if(rst)
        begin
          o <= 0;
          r_p <= 0;
          w_p <= 0;
        end
      else if(r && w && (!empty) && (!full))
        begin
          mem[w_p] <= i;
          w_p <= w_p + 1;
          o <= mem[r_p];
          r_p <= r_p + 1;
        end
      else if(r && (!empty))
        begin
          o <= mem[r_p];
          r_p <= r_p + 1;
        end
      else if(w && (!full))
        begin
          mem[w_p] <= i;
          w_p <= w_p + 1;
        end
      else
        begin
           o <=o;
          w_p <= w_p;
          r_p <= r_p;
        end
 
    end
endmodule


//TB
module tb();
  logic r, w, c, rst, empty, full;
  logic [3:0]i, o;
  fifo ss(o, i, r, w, c, rst, empty, full);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      rst = 1'b1;
      #6 r = 1'b0;
      @(negedge c)
      w = 1'b1;
      r = 1'b0;
      rst = 1'b0;
      i = 4'b0011;
      @(negedge c)
      r = 1'b1;
      @(negedge c)
      w = 1'b0;
      r = 1'b1;
      i = 4'b1110;
      @(negedge c)
      w = 1'b1;
      r = 1'b1;
      i = 4'b0110;
      
    end
  always #5 c = ~c;
endmodule
