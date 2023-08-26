class transaction;
  randc int a;
  randc int b;
  constraint aa {
    a<40;
    a>0;
  }
  constraint bb {
    b<60;
    b>40;
  }
endclass

class generator;
  mailbox mbx;
  transaction t;
  function new(mailbox  mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
  for(int i=0;i<10;i++) begin
    t=new();
    t.randomize();
    $display("[SENT]: a= %0d, b= %0d", t.a, t.b);
    mbx.put(t);
    #10;
  end
  endtask
endclass

class driver;
  mailbox mbx;
  transaction t;
  
  function new(mailbox mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    forever begin
      t=new();
      mbx.get(t);
      $display("[RXD]: a= %0d, b= %0d", t.a, t.b);
      #10;
    end
  endtask
endclass

module top;
  driver drv;
  generator gnt;
  transaction t;
  mailbox mbx;
  initial begin
    mailbox mbx;
    mbx=new();
    gnt=new(mbx);
    drv=new(mbx);
    fork
      gnt.run();
      drv.run();
    join
  end
endmodule


/*
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
*/
    
    
