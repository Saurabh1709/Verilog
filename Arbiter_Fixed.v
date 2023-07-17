module fixed_arbiter(gnt, req, c, r);
  input [3:0]req;
  input c, r;
  output reg [3:0]gnt;
  always@(posedge c)
    begin
      if(r)
        gnt <= 4'b0000;
      else if(req[3])
        gnt <= 4'b1000;
      else if(req[2])
        gnt <= 4'b0100;
      else if(req[1])
        gnt <= 4'b0010;
      else if(req[0])
        gnt <= 4'b0001;
      else
        gnt <= 4'b0000;
    end
endmodule


//TB
module tb;
  fixed_arbiter ss(gnt, req, c, r);
  logic [3:0]req;
  logic c, r;
  logic [3:0]gnt; 
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      r = 1'b1;
      #6 r = 1'b0;
      @(negedge c)
      req = 4'b1101;
      @(negedge c)
      req = 4'b1111;
      @(negedge c)
      req = 4'b0011;
      @(negedge c)
      req = 4'b0000;
      @(negedge c)
      req = 4'b1001;
     
    end
  always #5 c = ~c;
endmodule
