module posedge_detect(o, c, i);
  input i, c;
  output o;
  reg i_t;
  always@(posedge c)
    i_t <= i;
  assign o = i & (~i_t);
endmodule

//TB
module tb;
  logic i, c, o;
  posedge_detect ss(o, c, i);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    
    begin
      c = 1'b0;
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
    end
  always #5 c = ~c;
endmodule
