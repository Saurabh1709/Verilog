module tb;
  class randd;
    rand bit[2:0]a;
    randc bit[2:0]b;
    constraint c1{
    a==25 && b>2;
    }
  endclass
  
  randd r1;
  initial
    begin
      r1=new();
      repeat(10)
        begin
          r1.randomize();
          $display("a= %d   b= %d", r1.a, r1.b);
        end
    end
  initial #100 $finish;
endmodule
