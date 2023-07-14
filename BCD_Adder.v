//4 bit BCD adder
module bcd_adder(o, c, a, b);
  input [3:0]a, b;
  output logic [3:0]o;
  output logic c;
  logic [4:0]sum;
  always@(a, b)
    begin
      sum = a + b;
      if(sum > 9)
        begin
          sum = sum + 6;
          c = 1;
          o = sum[3:0];
        end
      else
        begin
          o = sum[3:0];
          c = 0;
        end
    end
endmodule




//TB
module tb;
  bcd_adder ss(o, c, a, b);
  logic [3:0]a, b, o;
  logic c;
  initial
    begin
      for(int i = 0; i <9 ; i++)
        begin
          a = $urandom_range(0, 4'b1001);
          b = $urandom_range(0, 4'b1001);
          #5; 
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
