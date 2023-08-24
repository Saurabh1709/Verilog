module tb;
  int a;
  int b;
  event done;
  event next;
  
  initial begin   ////////////////////////////Generator
    for(int i=0;i<10;i++) begin
      a=$urandom();
      $display("Sent %0d", a);
      #10;
      wait(next.triggered);
    end
    -> done;
  end
  
  initial begin   /////////////////////////////Driver
    forever begin
      #10;
      b=a;
      $display("Received %0d", b);
      ->next;
    end
  end
  
  initial begin   ////////////////////////////Controller
    wait(done.triggered);
    $finish();
  end
  
endmodule
