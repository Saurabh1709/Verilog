module tb;
  logic a, b, c;
  initial
    begin
      a = 1'b0;
      b = 1'b1;
      assert (a < b) 
        $display("GTG");
      else 
        $error("Error Detected");
    end
endmodule


//Ex_2
module tb;
  logic a, b, c;
  initial
    begin
      a = 1'b0;
      b = 1'b0;
      assert (a < b) 
      else 
        $error("Error Detected");    //Can use $fatal, $warning, $info(no problem)
    end
endmodule




