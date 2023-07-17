function [4:0]sum;       //function
  input [3:0]x, y, z;
  begin
    sum = x + y + z;
  end
endfunction

module full_adder(c, o, a, b, ci);   //adder module
  input [3:0]a, b, ci;
  output [3:0]o;
  output c;
  assign {c,o} = sum(a, b, ci);      //calling function
endmodule


//TB
module tb;
  logic [3:0]o, a, b, ci;
  logic c;
  full_adder dd(c, o, a, b, ci);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      a = 4'b1010;
      b = 4'b0101;
      ci = 1'b1;
    end
endmodule
