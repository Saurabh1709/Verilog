module tb;
  class c1;
    int a, b, c;
    function int f1(input int x, y);
      a = x;
      b = y;
      c = a*b;
      return c;
    endfunction
  endclass
  
  class c2;
    int d, e;
    c1 o3;
    function int f2(input int l, m);
      o3=new;
      $display(o3.f1(l, m));
    endfunction
  endclass
  
  c1 o1;
  c2 o5;
  initial
    begin
      o1 = new();
      $display(o1.f1(4, 5));
      o5 = new();
      o5.f2(3, 4);
      
    end
endmodule
