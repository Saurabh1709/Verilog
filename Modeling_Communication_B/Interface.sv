interface inf_i;
  logic [3:0]a, b;
  logic [4:0]sum;
endinterface

module top;
  inf_i inf();
  sum sum_i(.x(inf.a), .z(inf.sum), .y(inf.b));
  initial begin
    inf.a=10;
    inf.b=7;
    #10;
    inf.a=3;
    #10;
    inf.b=9;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    #100 $finish;
  end
endmodule
