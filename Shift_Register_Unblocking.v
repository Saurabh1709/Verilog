module shiftreg(q, i, load, c);
  input [3:0]i;
  input c, load;
  output reg [3:0]q;
  always@(posedge c)
    begin
      if(load)
        q <= i;
      else
        begin
          q[3] <= q[2];
          q[2] <= q[1];
          q[1] <= q[0];
          q[0] <= q[3];
        end
    end
  
endmodule


//TB
module tb;
  logic [3:0]i, q;
  logic load, c;
  shiftreg ss(q, i, load, c);
  
  initial
    begin
      c = 1'b0;
      load = 1'b1;
      i = 4'b0011;
      @(negedge c)
      load = 1'b0;

    end
    
  always #5 c = ~c;
 
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end

endmodule
