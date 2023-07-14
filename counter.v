//MY counter
module counter(o, c, r);
  input c, r;     //c = clock, r = reset
  output reg [7:0]o;
  always@(posedge c)
    begin
      if(r)
        o <= 8'b1;
      else
        o <= o + 8'h02;
    end
endmodule
