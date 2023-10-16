

class transaction;
  bit newd;
  rand bit [7:0]din;
  bit [7:0]dout;
 
  
  function transaction copy();
    copy = new();
    copy.newd = this.newd;
    copy.din = this.din;
    copy.dout = this.dout;
  endfunction
endclass
///////////////////////////////////////////////////////////////
class generator;
  transaction trans;
  mailbox #(transaction) mbx;
  event done;
  event sconxt;
  int counter=0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx=mbx;
    trans = new();
  endfunction
  
  
  task run();
    repeat(counter) begin
      trans.randomize();
      mbx.put(trans.copy);
      $display("[GEN] : din= %0d",trans.din);
      @(sconxt);
      $display(".............................................");
    end
    ->done;
  endtask
endclass
////////////////////////////////////////////////////////////////
class driver;
  virtual intf_design intf;
  mailbox #(transaction) mbx;
  mailbox #(bit [7:0]) mbxds;
  transaction trans;
  
  function new(mailbox #(transaction) mbx, mailbox #(bit [7:0]) mbxds);
    this.mbx = mbx;
    this.mbxds = mbxds;
  endfunction
  
  task reset();
    intf.rst<=1;
    intf.newd<=0;
    intf.din<=0;
    repeat(10) @(posedge intf.clk); //reset on clk, not sclk.
    intf.rst<=0;
    repeat(5) @(posedge intf.clk);
    $display("[DRV] : Reset");
    $display("..............................................");
  endtask
  
  task run();
    forever begin
      mbx.get(trans);
      intf.newd <= 1;
      intf.din <= trans.din;
      mbxds.put(trans.din);
      
      @(posedge intf.sclk);
      intf.newd<=0;
      @(posedge intf.done);
      $display("[DRV] : Data sent- din= %0d", trans.din);
      @(posedge intf.sclk);

    end
  endtask
endclass
///////////////////////////////////////////////////////////////
class monitor;
  transaction trans;
  mailbox #(bit [7:0]) mbx;
  bit [7:0]temp;
  virtual intf_design intf;
  
  function new(mailbox #(bit [7:0]) mbx);
    this.mbx=mbx;
  endfunction
  
  task run();
    trans = new();
    forever begin
      @(posedge intf.sclk);
      @(posedge intf.done);
      trans.dout = intf.dout;
      @(posedge intf.sclk);
      mbx.put(trans.dout);
      $display("[MON] : Data sent- din %0d", trans.dout);
    end
  endtask
endclass
//////////////////////////////////////////////////////////////
class scoreboard;
  mailbox #(bit [7:0]) mbxms;
  mailbox #(bit [7:0]) mbxds;
  bit [7:0]temp1;
  bit [7:0]temp2;
  
  event sconxt;
  
  function new(mailbox #(bit [7:0]) mbxms, mailbox #(bit [7:0]) mbxds);
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
  mailbox #(bit [7:0]) mbxds;
  mailbox #(bit [7:0]) mbxms;
  
  event sconext;
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
    drv.intf = this.intf;
    mon.intf = this.intf;
    
    sco.sconxt = sconext;
    gen.sconxt = sconext;

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
  spi dut(intf.clk, intf.rst, intf.din, intf.newd, intf.dout, intf.done);
  environment env;
  
  initial intf.clk <= 0;
  always #10 intf.clk <= ~intf.clk;
  
  assign intf.sclk = dut.s0.sclk;
  
  initial begin
    env = new(intf);
    env.gen.counter = 4;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule
