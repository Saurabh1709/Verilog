module s_adder(a, b, sum, carry, clk, rst);
  input a, b, rst;
  input clk;
  output reg sum, carry;
  always@(posedge clk) begin
    if(rst==1) begin
      sum <= 0;
      carry <= 0;
    end
    else begin
      {carry, sum} = a + b + carry;
    end
  end
endmodule

/*
module serialadder(s, c, a, b, clk, r);   //Alternate way
  input a, b, r;
  input clk;
  output reg s;
  output c;
  reg c1, c2;
  assign c = c2;
  always@(posedge clk)
    begin
      if(r)
        begin
          s = 0;
          c1=0;
          c2= 0;
        end
    else
      {c2,s} = a + b + c1; 
    end
  always@(c)
    begin
      c1 <= c2;
    end
  
endmodule
*/

//TB
module test;
  s_adder ss(a, b, sum, carry, clk, rst);
  bit a, b, rst;
  bit clk;
  bit sum, carry;
  
  initial clk=0;
  always #10 clk = ~clk;
  
  initial begin
    rst = 1;
    @(negedge clk);
    rst = 0;
    repeat(20) begin
      a = $urandom;
      b = $urandom;
      @(negedge clk);
    end
  end
  
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    #350 $finish;
  end
  
endmodule
