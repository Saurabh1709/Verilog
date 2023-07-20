module ram(o, add, i, c, w, oe, cs);
  input [7:0]i;
  input [2:0]add;
  input w, oe, cs, c;
  output [7:0]o;
  reg [7:0]mem[7:0];
  reg [7:0]data;
  always@(posedge c)
    begin
      if(w && cs)
        mem[add] = i;
      else if(!w && cs)
        data = mem[add];
    end
  assign o = (cs && oe && !w)?data:4'bz;
endmodule

//TB
module tb;
  ram bb(o, add, i, c, w, oe, cs);
  logic [7:0]i;
  logic [3:0]add;
  logic w, oe, cs, c;
  logic [7:0]o;
  always #5 c = ~c;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      cs = 1'b1;
      w = 1'b0;
      add = 3'b001;
      oe = 1'b0;
      @(negedge c)
      i = 8'h22;
      add = 3'b001;
      w = 1'b1;
      @(negedge c)
      w = 1'b0;
      add = 3'b011;
      oe = 1'b0;
      @(negedge c)
      w = 1'b0;
      add = 3'b001;
      oe = 1'b1;
      
      
    end
endmodule
