primitive dff_nedge (q, c, r, d);          //Declaring DFF primitive
  output reg q;
  input c, r, d;

  initial q = 0;
  table
        ?       1     ?  :  ?  :  0; 
        ?      (??)   ?  :  ?  :  -; 
    
      (10)      0     1  :  ?  :  1; 
      (10)      0     0  :  ?  :  0; 

      (1x)      0     ?  :  ?  :  -; 
    
      (0?)      0     ?  :  ?  :  -; 
      (x1)      0     ?  :  ?  :  -; 
    
       ?        0   (??) :  ?  :  -; 
  endtable
endprimitive



//TB
module udp_tb;
  reg c, r, d;
  wire q;
  
  dff_nedge ss(q, c, r, d);      //Calling primitive in TB
  
  initial c = 0;
  always #5 c=~c;
  
  initial begin
    
    r = 1;
    #10 r = 0;
    d = 1;
    @(posedge c)
    d = 0;
    @(posedge c)
    d = 0;
    @(posedge c)
    d = 1;
    @(posedge c)
    d = 0;
    
  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
