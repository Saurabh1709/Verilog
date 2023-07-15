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

//multiplying a single bit to a each bit of a 4 bit number(a step for a 4 bit multiplier)
module andasmul(a, b, c);
  input [3:0]a;
  input b;
  output [3:0]c;
  assign c = a & {4{b}};
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

//Best type of delay  where signal transition at input is not ignored
module andasmul(a, b, c);
  input a;
  input b;
  output reg c;
  always@(*)
    begin
    c <= #4 a & b;  //Best type  of delay
    end
endmodule


