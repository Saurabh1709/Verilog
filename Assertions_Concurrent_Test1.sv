module tb;
  logic a=0, b=0, c=0;
  always #5 c = ~c;
  
  property prp;
    @(posedge c) a ##1 b;
    
  endproperty
  assert property(prp) $info("You got it: ", $time);
    else $info("Wrong");
   
    initial
        #100 $finish;
  initial
    begin
      @(negedge c) //10 ns
      a = 0;
      b = 1;
      
      @(negedge c) //20 ns
      a = 1;
      b = 1;
     
      @(negedge c) //30 ns
      a = 1;
      b = 1;
     
      @(negedge c) //40 ns
      a = 1;
      b = 0;
  
      @(negedge c) //50 ns
      a = 1;
      b = 1;
     
      @(negedge c) //60 ns
      a = 1;
      b = 1;
   
    end
    initial
      begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
      end
endmodule


