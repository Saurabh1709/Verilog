//Latch
module dlatch(q, en, d);
  input en, d;
  output q;
  assign q = en? d: q;
endmodule

//TB
module tb;
  dlatch tb1(q, en, d);
  logic en, d, q;
  initial
    begin
      en = 1'b1;
      d = 1'b1;
      #4;
      d = 1'b0;
      #4;
      en = 1'b0;
      #1;
      d = 1'b0;
      #4;
      en = 1'b1;
      #1;
      d = 1'b1;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
