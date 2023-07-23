module sum(o, n);
  output reg [31:0]o;
  input [31:0]n;
  always@(*)
    begin
      f11(n, o);
    end
 
  
  function [31:0]f00;
    input [31:0]i;
    begin
      f00 = i*i;
      
    end
  endfunction
  
  task f11;
    input [31:0]n;
    output [31:0]f1;
    integer j;
    begin
      f1 = 0;
      for(j=0; j<=n; j++)
        begin
          
          f1 = f1 + f00(j);
          $display(f1);
        end
      
    end
  endtask
    
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
