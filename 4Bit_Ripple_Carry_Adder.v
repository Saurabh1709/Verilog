//Full Adder
module FA(s, c, x, y);
  input [3:0]x, y;
  output [3:0]s;
  output c;
  reg [3:0]c1;
  full_add a1(s[0], c1[1], x[0], y[0], 1'b0);
  full_add a2(s[1], c1[2], x[1], y[1], c1[1]);
  full_add a3(s[2], c1[3], x[2], y[2], c1[2]);
  full_add a4(s[3], c, x[3], y[3], c1[3]);
  
endmodule

module full_add(s, c, x, y, z);
  input x, y, z;
  output s, c;
  assign {c, s} = x + y + z;
endmodule

//TB
module tb;
  FA aa(s, c, x, y);
  logic [3:0]x, y, s;
  logic c;
  initial
    begin
      x = 8;
      y = 7;
      #5 x = 11;
      y = 5;
      
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
