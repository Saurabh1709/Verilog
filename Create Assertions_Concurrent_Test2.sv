//Using implication operator
module tb;
  logic a, b, c, clk=0;
  always #5 clk = ~clk;
 
  property aa;
    @(posedge clk) c |-> ##[1:2] b;
  endproperty
  
  assert property(aa);
   
    
    
    initial
        #100 $finish;
  initial
    begin
      a =0;
      b =0;
      c =0;
      #10;   //10
      a =1;
      b =0;
      c =1;
      #10;   //20
      a =0;
      b =1;
      c =1;
      #10;   //30
      a =1;
      b =1;
      c =1;
      $display($time);
      #10;   //40
      a =0;
      b =0;
      c =1;
      #10;   //50
      a =1;
      b =0;
      c =0;
   
    end
    initial
      begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
      end
   
endmodule
