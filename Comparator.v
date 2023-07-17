module comparator(a, b, e, g, l);
  input [3:0]a, b;
  output e, g, l;
  assign e = (a == b);
  assign g = (a > b);
  assign l = (a < b);
endmodule

//TB
module tb;
  logic [3:0]a, b;
  logic e, g, l;
  comparator ff(a, b, e, g, l);
  initial
    begin
      for (int x=0; x <5; x++)
        begin
          a = $urandom_range(0, 4'hf);
          b = $urandom_range(0, 4'hf);
          #5;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
