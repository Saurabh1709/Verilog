module sub(a, b, c);
  input signed [3:0]a, b;
  output [3:0]c;
  assign c= b>>>1; 
endmodule

//TB
module tb;
  sub aa(a, b, c);
  logic [3:0]a, b;
  logic [3:0]c;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      a = 4'b0101;
      b = 4'b1010;
    end
endmodule
