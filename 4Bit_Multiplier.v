//4 Bit Multiplier
module mul(a, b, c);
  input [3:0]a, b;
  output logic [7:0]c;
  always@(a, b)
    begin
      c = 0;
      for(int i=0; i<b; i++)
        begin
          c = c + a;
          $display("%d", c);
        end
    end
endmodule



//TB
module tb;
  mul cc(a, b, c);
  logic [3:0]a, b;
  logic [7:0]c;
  initial
    begin
      a = 7;
      b = 6;
      #5 a = 9;
      b = 6;
      #5 a = 5;
      b = 8;
      #5 a = 2;
      b = 0;
      
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
