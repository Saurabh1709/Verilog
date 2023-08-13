module tb;
  class parent;
    virtual function void f1();
      $display("You are in parent class");
    endfunction
  endclass
  
  class child extends parent;
    function void f1();
      $display("You are in child class");
    endfunction
  endclass
  
  parent p;
  child c;
  initial
    begin
      c = new();
      p = new();
      p.f1();
      p = c;
      p.f1();
    end
endmodule


// Using Cast
module tb;
  class parent;
    function void f1();
      $display("You are in parent class");
    endfunction
  endclass
  
  class child extends parent;
    function void f2();
      $display("You are in child class");
    endfunction
  endclass
  
  parent p;
  child c, c1;
  
  initial
    begin
      c = new();
      p = new();
      p = c;
      $cast(c1, p);
      c1.f2();
    end
endmodule
