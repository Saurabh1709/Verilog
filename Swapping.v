module tb;
  logic [3:0]a, b;
  
  initial
    begin
      
          a = 4'b0110;
          b = 4'b1011;
          
    end
  initial
    begin
    #5;
      a <= b;                  //Swapping 
      b<= a;
    end
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
