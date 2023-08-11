module tb;

  reg [3:0]b;
  wire [3:0]a;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  assign a = b;
  initial
    begin
  
   
      b = 2;
      #5;
  
      b = 4;
      #5;
      
      b = 6;
      #5;
     
      b = 8;
      #5;
 
      b = 10;
      #5;
    
      b = 12;
      #5;
     
      b = 5;
      #5;
     
      b = 5;
      #5;
     
      b = 7; 
    end
  initial
    begin
      #8;
      force a = 14;
      #9;
      release a;
    end
endmodule
