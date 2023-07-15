primitive andg(c, a, b); //Output first in UDP(User defined primitives)
input a, b;
output c;
table
  0  0 : 0;
  0  1 : 0;
  1  0 : 0;
  1  1 : 1;
endtable
endprimitive

module andgate(a, b, c);
  input a, b;
  output c;
  andg bb(c, a, b);
endmodule


//TB
module tb;
  andgate vv(a, b, c);
  logic a, b;
  logic c;
  initial
    begin
      a = 0;
      b = 1;
      #5 a = 1;
      b = 1;
      
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
