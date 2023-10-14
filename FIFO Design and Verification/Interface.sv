module add(input [3:0]a, b, output reg [4:0]c, input clk);
  always@(posedge clk) begin
    c=a+b;
  end
endmodule


/////TB


interface inf;
  logic [3:0]a, b;
  logic [4:0]c;
  logic clk;
endinterface

class driver;
  virtual inf infd;
  task run();
    repeat(2) @(posedge infd.clk);
    infd.a<=4;
    infd.b<=11;
  endtask
endclass

module top;
  inf inft();
  add dut(inft.a, inft.b, inft.c, inft.clk);
  initial inft.clk<=0; 
  driver drv;
  initial begin
    drv=new();
    drv.infd=inft;
    drv.run;
  end
  always #10 inft.clk=~inft.clk;
  initial begin
    $dumpvars(1);
    $dumpfile("dump.vcd");
    #100 $finish;
  end
endmodule
