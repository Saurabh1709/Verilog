class generator;
  int data=11;
  mailbox mbx;
  
  task run();
    mbx.put(data);
    $display("[Data Sent]: %0d", data);
  endtask
endclass

class driver;
  int datac=0;
  mailbox mbx;
  
  task run();
    mbx.get(datac);
    $display("[Data Rxd]: %0d", datac);
  endtask
endclass

module tb;
  generator gnt;
  driver drv;
  mailbox mbx;
  
  initial begin
    gnt=new();
    drv=new();
    mbx=new();
    
    gnt.mbx=mbx;
    drv.mbx=mbx;
    
    gnt.run;
    drv.run;
  end
endmodule
    
    
