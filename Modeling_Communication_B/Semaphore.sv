//Here multiple classes trying to write on to the same variable(a).

class first;
  rand int a;
  constraint aa {
    a<70;
    a>10;
  }
endclass

class second;
  rand int a;
  constraint aa {
    a>70;
    a<90;
  }
endclass

class main;
  semaphore sem;
  first f;
  second s;
  int a;
  
  task first_shedule();
  	sem.get(1);
    for(int i=0;i<10;i++) begin
      f.randomize();
      a=f.a;
      $display("First's Data Sent: %0d", f.a);
      #10;
  	end
    sem.put(1);
    $display("Semaphore Released");
  endtask
  
  task second_shedule();
    sem.get(1);
    for(int j=0;j<10;j++) begin
      s.randomize();
      a=s.a;
      $display("Second's Data Sent: %0d", s.a);
      #10;
    end
  endtask
  
  task summer();
    sem=new(1);
    f=new();
    s=new();
    fork
      first_shedule();
      second_shedule();
    join
  endtask
endclass


module transaction();
  main m;
  initial begin
    m=new();
    m.summer();
  end
  initial #250 $finish;
endmodule
