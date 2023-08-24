module tb;
  int a;
  int b;
  event done;
  event next;
  
  task generator();   ///////////////////////////Generator
    for(int i=0;i<10;i++) begin
      a=$urandom();
      $display("Sent %0d", a);
      #10;
      wait(next.triggered);
    end
    -> done;
  endtask
  
  task driver();   ///////////////////////////////Driver
    forever begin
      #10;
      b=a;
      $display("Received %0d", b);
      ->next;
    end
  endtask
    
  task controller();    //////////////////////////////Controller
    wait(done.triggered);
    $display("Recieved all the stimulus");
    $finish();
  endtask
  
  initial begin        ////////////////////////////////Execution
    fork
      generator();
      driver();
      controller();
    join
  end
  
endmodule
