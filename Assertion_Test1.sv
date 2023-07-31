module tb;
  logic a, b, c;
  initial
    begin
      a = 1'b0;
      b = 1'b1;
      assert (a < b) 
        $display("GTG");
      else 
        $error("Error Detected master Saurabh");
    end
endmodule
