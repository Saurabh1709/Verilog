module force_release;
  reg [3:0] a;
  wire [3:0] b;
  
  assign b = 2;
  initial begin
    $monitor("At time T = %0t: a = %0d, b = %0d", $time, a, b, ".");
    a = 5;
    #20 a = 7;
  end
  
  initial begin
    #5;
    $display("At time T = %0t: force a and b", $time, ".");
    force a = 3;
    force b = 4;
    #5 release a; //as reg, retain the current value, until changed.
    release b;    //as wire, will take the previously assigned value.
    $display("At time T = %0t: release a and b", $time, ".");
  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
