module tb;
  int a;
  int b;
  event done;
//////////////////////////////////////////////Generator
  initial begin  
    for(int i=0;i<10;i++) begin
      a=$urandom();
      $display("Sent %0d", a);
      #10;
    end
    -> done;
  end
////////////////////////////////////////////////Driver
  initial begin   
    forever begin
      #10;
      b=a;
      $display("Received %0d", b);
    end
  end
  
////////////////////////////////////////////Controller
  
  initial begin   
    wait(done.triggered);
    $finish();
  end
  
endmodule
