class transaction;
  rand bit newd;
  rand bit [11:0]din;
  bit cs;
  bit mosi;
  
  function void display(input string tag);
    $display("[%0s] : newd= %0d, din= %0d, mosi= %0d, cs= %0d", tag, newd, din, mosi, cs);
  endfunction
  
  function transaction copy();
    copy = new();
    copy.newd = this.newd;
    copy.din = this.din;
    copy.cs = this.cs;
    copy.mosi = this.mosi;
  endfunction
endclass
///////////////////////////////////////////////////////////////
class generator;
  transaction trans;
  mailbox #(transaction) mbx;
  event done;
  event drvnxt;
  event sconxt;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
    trans = new();
  endfunction
  
  int counter=0;
  task run();
    repeat(counter) begin
      trans.randomize();
      mbx.put(trans.copy);
      trans.display("GEN");
      @(drvnxt);
      @(sconxt);
      $display(".............................................");
    end
    ->done;
  endtask
endclass
/////////////////////////////////////////////////////////////////
class driver;
  virtual intf_design intf;
  mailbox #(transaction) mbx;
  mailbox #(bit [11:0]) mbxds;
  transaction trans;
  event drvnxt;
  
  function new(mailbox #(transaction) mbx, mailbox #(bit [11:0]) mbxds);
    this.mbx = mbx;
    this.mbxds = mbxds;
  endfunction
  
  task reset();
    intf.rst<=1;
    intf.newd<=0;
    intf.din<=0;
    intf.mosi<=0;
    intf.cs<=1;
    repeat(10) @(posedge intf.clk); //reset on clk, not sclk.
    intf.rst<=0;
    repeat(5) @(posedge intf.clk);
    $display("[DRV] : Reset");
    $display("..............................................");
  endtask
  
  task run();
    forever begin
      mbx.get(trans);
      @(posedge intf.sclk);
      intf.newd <= 1;
      intf.din <= trans.din;
      mbxds.put(trans.din);
      
      @(posedge intf.sclk);
      intf.newd<=0;
      wait(intf.cs==1);
      $display("[DRV] : Data sent- din= %0d", trans.din);
      ->drvnxt;
    end
  endtask
endclass
///////////////////////////////////////////////////////////////
class monitor;
  //transaction trans;
  mailbox #(bit [11:0]) mbx;
  bit [11:0]temp;
  virtual intf_design intf;
  
  function new(mailbox #(bit [11:0]) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    forever begin
      @(posedge intf.sclk);
      wait(intf.cs==0);    //Start of transaction
      @(posedge intf.sclk);
      for(int i=0; i<12; i++) begin
        @(posedge intf.sclk);
        temp[i]=intf.mosi;
      end
      wait(intf.cs==1);   //End of transaction
      mbx.put(temp);
      $display("[MON] : Data sent- din %0d", temp);
    end
  endtask
endclass
//////////////////////////////////////////////////////////////
class scoreboard;
  mailbox #(bit [11:0]) mbxms;
  mailbox #(bit [11:0]) mbxds;
  bit [11:0]temp1;
  bit [11:0]temp2;
  
  event sconxt;
  
  function new(mailbox #(bit [11:0]) mbxms, mailbox #(bit [11:0]) mbxds);
    this.mbxds=mbxds;
    this.mbxms=mbxms;
  endfunction
  
  task run();
    forever begin
      mbxds.get(temp1);
      mbxms.get(temp2);
      $display("[SCO] : DRV= %0d, MON= %0d", temp1, temp2);
      if(temp1==temp2) $display("[SCO] : Data Match");
      else $display("[SCO] ; Data Mismatch");
      $display("...........................................");
      ->sconxt;
    end
  endtask
endclass
//////////////////////////////////////////////////////////////

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  mailbox #(transaction) mbxgd;
  mailbox #(bit [11:0]) mbxds;
  mailbox #(bit [11:0]) mbxms;
  
  event sconxt;
  event drvnxt;
  virtual intf_design intf;
  
  function new(virtual intf_design intf);
    mbxgd = new();
    mbxds = new();
    mbxms = new();
    
    gen = new(mbxgd);
    drv = new(mbxgd, mbxds);
    mon = new(mbxms);
    sco = new(mbxms, mbxds);
    
    this.intf = intf;
    drv.intf = intf;
    mon.intf = intf;
    
    sco.sconxt = sconxt;
    gen.sconxt = sconxt;
    
    drv.drvnxt = drvnxt;
    gen.drvnxt = drvnxt;

  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();        
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
endclass
//////////////////////////////////////////////////////////////
module tb;
  intf_design intf();
  spi aa(intf.clk, intf.rst, intf.din, intf.newd, intf.sclk, intf.mosi, intf.cs);
  environment env;
  
  initial intf.clk <= 0;
  always #5 intf.clk <= ~intf.clk;
  
  initial begin
    env = new(intf);
    env.gen.counter = 20;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule
