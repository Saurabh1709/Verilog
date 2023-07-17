task summer;     //task declaration
  
  input [3:0]x, y, z;
  output reg c;
  output reg [3:0]s;
  begin
    {c, s} = x + y + z;
  end
endtask

module full_adder(carry, sum, a, b, ci);      //Full adder Block
  input [3:0]a, b, ci;
  output reg [3:0]sum;
  output reg carry;
  always@(*)
    begin
      summer(a, b, ci, carry, sum);           //Calling task
    end
endmodule

//TB
module tb;
  logic [3:0]sum, a, b, ci;
  logic carry;
  full_adder dd(carry, sum, a, b, ci);
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
