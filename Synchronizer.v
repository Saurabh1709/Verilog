module sync_2ff(osync, c, r, d);
  input c, d, r;
  output osync;
  reg [1:0]q;
  always@(posedge c)
    begin
      if(r)
        q <= 0;
      else
        begin
          q[1]<=q[0];
          q[0]<=d;
        end
    end
  assign osync = q[1];
endmodule


/TB
module tb;
  logic osync, c, r, d;;
  sync_2ff ss(osync, c, r, d);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    
    begin
      d = 1'b0;
      c = 1'b0;
      r = 1'b1;
      @(negedge c)
      r = 1'b0;
      @(negedge c)
      d = 1'b1;
      @(negedge c)
      d = 1'b0;
      @(negedge c)
      d = 1'b1;
      @(negedge c)
      d = 1'b1;
    end
  always #5 c = ~c;
 
endmodule
