module lifo(o, i, c, r, wr, rd, empty, full);
  input [7:0]i;
  
  input c, r, wr, rd;
  output reg [7:0]o;
  reg [7:0]mem[7:0];
  reg [3:0]ptr;
  output full, empty;
  always@(posedge c)
    begin
      if(r)
        begin
          o <= 0;
          ptr <= 0;
        end
      else if(wr && !full)
        begin
          mem[ptr]<=i;
          ptr <= ptr + 1;
        end
      else if(rd && !empty)
        begin
          o <= mem[ptr-1];
          ptr <= ptr - 1;
        end
      else
        begin
          o <= o;
          ptr <= ptr;
        end
    end
  assign full= (ptr==4'b1000)?1:0;
  assign empty= (ptr==4'b0)?1:0;
endmodule


//TB
module tb;
  lifo ss(o, i, c, r, wr, rd, empty, full);
  logic [7:0]i;
  logic c, r, wr, rd;
  logic [7:0]o;
  logic full, empty;
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
      r = 1'b1;
      rd = 1'b0;
      wr = 1'b0;
      #6 r = 1'b0;
      @(negedge c)
      wr = 1'b1;
      i = 8'h77;
      rd = 1'b0;
      @(negedge c)
      i = 8'h22;
      wr = 1'b1;
      rd = 1'b0;
      @(negedge c)
      rd = 1'b1;
      
      wr = 1'b0;
      
      @(negedge c)
      wr = 1'b0;
      rd = 1'b1;
      
      
    end
endmodule
