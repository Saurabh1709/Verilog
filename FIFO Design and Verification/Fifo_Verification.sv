  
class transaction;
  rand bit opr; //1:Write, 0:Read
  bit wr, rd, full, empty;
  rand bit [7:0]din;
  bit [7:0]dout;
  
  constraint cons {
    opr dist {0:/50 , 1:/50};
  }
  
  task display(input string tag);
    $display("[%0s] opr= %0d, wr=%0d, rd=%0d, full=%0d, empty=%0d, din=%0d, dout=%0d", tag, opr, wr, rd, full, empty, din, dout);
  endtask
endclass
///////////////////////////////////////////
class generator;
  transaction trans;
  mailbox #(transaction) mbx;
  event done;
  event next;
  int count=0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    trans = new();
  endfunction
  
  task run();
   
    repeat(count) begin
      assert(trans.randomize()) else $error("Randomization failed");
      mbx.put(trans);
      $display(".......................................");
      $display("[GEN] opr=%0d, din=%0d", trans.opr, trans.din);
      @(next);
    end
    ->done;
  endtask
endclass
////////////////////////////////////////////
class driver;
  virtual intf_dut intf;
  transaction trans;
  mailbox #(transaction) mbx;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task reset();
    intf.rst <= 1;
    intf.wr <= 0;
    intf.rd <= 0;
    intf.din <= 0;
    repeat(2) @(posedge intf.clk);
    intf.rst <= 0;
    $display("Reset Done");
    $display("..........................................");
  endtask
  
  task write();
    @(posedge intf.clk);
    intf.wr <= 1;
    intf.rst <= 0;
    intf.rd <= 0;
    intf.din <= trans.din;
    @(posedge intf.clk);
    intf.wr <= 0;
    $display("Write Operation");
    $display("[DRV] din: %0d", intf.din);
    @(posedge intf.clk);
  endtask
  
  task read();
    @(posedge intf.clk);
    intf.wr <= 0;
    intf.rd <= 1;
    intf.rst <= 0;
    @(posedge intf.clk);
    intf.rd <= 0;
    $display("Read Operation");
    @(posedge intf.clk);
  endtask
  
  task run();
    forever begin
      mbx.get(trans);
      if(trans.opr==1) write();
      else read();
    end
  endtask
endclass
///////////////////////////////////////////////////

class monitor;
  virtual intf_dut intf;
  transaction trans;
  mailbox #(transaction) mbx;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    trans = new();
    forever begin
      repeat(2) @(posedge intf.clk);
      trans.rd = intf.rd;
      trans.wr = intf.wr;
      trans.din = intf.din;
      trans.full = intf.full;
      trans.empty = intf.empty;
      @(posedge intf.clk);
      trans.dout = intf.dout;
      mbx.put(trans);
      trans.display("MON");
      
    end
  endtask
endclass
///////////////////////////////////////////////////
class scoreboard;
  transaction trans;
  mailbox #(transaction) mbx;
  event next;
  bit [7:0]queue[$];
  bit [7:0]temp;
  int err=0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction
  
  task run();
    forever begin
      mbx.get(trans);
      trans.display("SCO");
      
      if(trans.wr==1) begin
        if(trans.full==0) begin
          queue.push_front(trans.din);
          $display("Data in queue %0d", trans.din);
        end
        else $display("Fifo Full");
        $display(".................................");
      end
      
      if(trans.rd==1) begin
        if(trans.empty==0) begin
          temp = queue.pop_back();
          
          if(trans.dout == temp) 
            $display("Data match");
          else begin
            err++;
            $error("Data Mismatch");
          end
        end
        else $display("Fifo Empty");
                      
       $display("........................................");
      end
      
      ->next;
    end
  endtask
  
endclass
////////////////////////////////////////////////////////
class environment;
  scoreboard sco;
  monitor mon;
  driver drv;
  generator gen;
  event nextgs;
  virtual intf_dut intf;
  mailbox #(transaction) mbxgd;
  mailbox #(transaction) mbxms;
  
  function new(virtual intf_dut intf);
    mbxgd = new();
    mbxms = new();
    sco = new(mbxms);
    gen = new(mbxgd);
    drv = new(mbxgd);
    mon = new(mbxms);
    this.intf = intf;
    
    drv.intf = this.intf;
    mon.intf = this.intf;
    
    sco.next = nextgs;
    gen.next = nextgs;
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
    $display("Simulation Finished with %0d error", sco.err);
    $finish;
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
endclass
//////////////////////////////////////////////////////
module tb;
  intf_dut intf();
  fifo dut(intf.rst, intf.clk, intf.din, intf.dout, intf.rd, intf.wr, intf.full, intf.empty);
  
  environment env;
  
  initial intf.clk <= 0;
  always #10 intf.clk <= ~intf.clk;
  
  initial begin
    env = new(intf);
    env.gen.count=20;
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule

/////////////////////////////////
interface intf_dut;
  logic rst, clk, wr, rd, empty, full;
  logic [7:0]din, dout;
endinterface
