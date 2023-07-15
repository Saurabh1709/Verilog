//Type 1:
module latch(r, q1, q, s);
  input r, s;      
  output q, q1;
  assign q =  ~((q1) | r);
  assign q1 = ~(q | s);
endmodule


//Type 2;
module latch(r, q1, q, s);
  input r, s;
  output q, q1;
  nor s0(q, q1, r), s1(q1, q, s);
endmodule

//TB
module tb;
  latch bb(r, q1, q, s);
  logic r, q1, q, s;
  initial
    begin
     
     
      r = 0;
      s = 1;
      #10;
      r = 1;
     s = 0;
      #10;
      r = 0;
     s = 0;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule




