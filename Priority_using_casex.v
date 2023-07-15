module priorityen(a, o);   //Priority encoder
  input [3:0]a;
  output reg [1:0]o;
  always@(a)
    begin
      casex(a)
        4'b1xxx: o = 3;    //Highest priority
        4'b01xx: o = 2;
        4'b001x: o = 1;
        4'b0001: o = 0;
        default: o = o;
      endcase
    end
endmodule


//TB
module pe;
  priorityen sss(a, o);
  logic [3:0]a;
  logic [1:0]o;
  initial
    begin
      for(int x=0; x<5 ; x++)
        begin
          a = $urandom_range(0, 4'b1110);
          #4;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule

