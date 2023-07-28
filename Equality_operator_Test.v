module tb;
  logic [3:0]a, b, c;
  initial
    begin
      a=4'b100x;
      b=(a==4'b100x); 
      c=(a===4'b100x);
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #50 $finish;
    end

endmodule
