module assign_deassign;
  reg [3:0] a;
  
  reg [3:0]b;
  initial
    begin
      b = 2;
      #6
      b = 3;
      #2
      b=4;
    end
  initial begin
    
    a = 5;
    #20 a = 7;
  end
  
  initial begin
    #5;
    
    assign a = b;
    
    #5 deassign a; //retain the current value, until changed.
    
  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
