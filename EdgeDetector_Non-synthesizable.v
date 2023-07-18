module edge_det(i, o);
  input i; 
  output o;
  reg b;
assign o=i&b;

  always @(i)
     b<=#2 ~i;    //best delay assignment

endmodule


//TB
module tb;
  logic i, o;
  edge_det ss(i, o);
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    
    begin
      
      i = 1'b0;
      #5;
      i = 1'b1;
      #5;
      i = 1'b0;
      #5;
      i = 1'b1;
      #5;
      i = 1'b1;
      #5;
      i = 1'b0;
      #5;
      i = 1'b1;
      #5;
      i = 1'b0;
      #5;
      i = 1'b1;
    end
 
endmodule
