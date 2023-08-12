module tb;
  class c1;
    int a, b, c;
    function new(input int x, y);
      a = x;
      b = y;
      $display("Let's start");
    endfunction
    function int f1();
      c = a*b;
      return c;
    endfunction
  endclass
  
  class c2 extends c1;
    function new(input int q, w);
      super.new(q,w);
    endfunction
  endclass

  c2 o5;
  initial
    begin
      o5 = new(4, 5);
      $display(o5.f1());
    end
endmodule
