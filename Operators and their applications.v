//1's complement
module complement(b, a);
  input [3:0]a;
  output [3:0]b;
  assign b = ~a;    //~: bitwise
endmodule

//2's compement
module complement(b, a);
  input [3:0]a;
  output [3:0]b;
  assign b = ~a + 1;
endmodule

//Square
module square (b, a);
  input [3:0]a;
  output [7:0]b;
  assign b = a**2'b10;
endmodule

//multiplier
module mult (c, b, a);
  input [3:0]a, b;
  output [7:0]c;
  assign c = a*b;
endmodule


//Operation on signed numbers
module logics(c, a, b);
  input signed [3:0]a, b;     //representing signed numbers
  output reg signed [3:0]c;
  assign c = a *2;
 
endmodule


