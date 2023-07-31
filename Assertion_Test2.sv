module tb;
  logic a, b;
  logic [3:0]c = 0;       //Set error count = 0
  initial
    begin
      a = 1'b0;
      b = 1'b0;
      assert (a < b) 
      else 
        begin
          c++;
          $error("Error Detected");      //Count errors
          $display(c);
        end
    end
endmodule
