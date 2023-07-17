module updown(q, m, r, c);
  input m, r, c;
  output int q;
  always@(posedge c)
    begin
      if(r)
        q = 0;
      else
        q = m?(q+1):(q-1);
    end
endmodule

//TB
module tb;
  logic m, r, c;
  int q;
  updown ss(q, m, r, c);
  
  initial
    begin
      c = 1'b0;
      
      r= 1'b1;
      @(negedge c)
      r = 1'b0;
      m = 1'b1;
      @(negedge c)
      @(negedge c)
      @(negedge c)
      @(negedge c)
      m = 1'b0;

          
    end
  always #5 c = ~c;
 
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
