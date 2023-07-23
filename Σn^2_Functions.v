module sum(o, n);
  output [31:0]o;
  input [31:0]n;
  assign o=f1(n);
  
  function [31:0]f0;
    input [31:0]i;
    begin
      f0 = i*i;
      
    end
  endfunction
  
  function [31:0]f1;
    input [31:0]n;
    integer j;
    begin
      f1 = 0;
      for(j=0; j<=n; j++)
        begin
          f1 = f1 + f0(j);
          $display(f1);
        end
      
    end
  endfunction
    
endmodule



//TB
module tb;
  sum gg(o, n);
  logic [31:0]o;
  logic [31:0]n;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
      
    end
  initial
    begin
      n = 5;
    end
endmodule
