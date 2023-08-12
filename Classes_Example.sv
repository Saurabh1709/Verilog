module tb;
class ss;
  int number;
  task set (input int i);
    number = i*i;
  endtask
  
  function int get();
    $display(number);
    
  endfunction
  
endclass

ss n1;
initial
  begin
    n1 = new();
    n1.set(5);
    n1.get();
  end
endmodule
