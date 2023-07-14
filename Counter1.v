//Another way of writing counter with wired output(o).
module counter(o, c, r);
  input c, r;
  output [7:0]o;
  reg [7:0]o_1;
  always@(posedge c)
    begin
      if(r)
        o_1 <= 8'b1;
      else
        o_1 <= o;
    end
  assign o = o_1 + 8'h02;
endmodule
