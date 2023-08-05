//Asynchronous_FIFO
module Asynchronous_FIFO(full, empty, wclk, rclk, w_en, r_en, rdata, wdata, wrst, rrst);
  parameter ADD=3, DATA=8, DEPTH=1<<ADD;
  input rrst, wrst, rrst, w_en, r_en, wclk, rclk;
  input [DATA-1:0]wdata;
  output reg full, empty;
  output [DATA-1:0]rdata;
  
  reg [ADD:0]wptr, rptr;
  reg [ADD-1:0]wadd, radd;
  reg [DATA-1:0]fifo_mem[0:DEPTH-1];
  
  write_logic f1(full,wclk,wptr,req_r,wadd, wrst, w_en);
  read_logic f2(empty,rclk,rptr,req_w,radd, rrst, r_en);
  sync_write f3(req_w, wptr, rclk, rrst);
  sync_read f4(req_r, rptr, wclk, wrst);
  
  assign rdata=fifo_mem[radd];
  
  always@(posedge wclk)
    begin
      if(w_en && (~full))
        fifo_mem[wadd]<=wdata;
    end
  
endmodule


//Write Logic and full condition
module write_logic(full,wclk,wptr,req_r,wadd, wrst, w_en);
  parameter ADD=3, DATA=8;
  input wclk, wrst, w_en;
  input [ADD:0]req_r;
  output reg full;
  wire fullt;
  output reg [ADD:0]wptr;
  output reg [ADD-1:0]wadd;
  reg [ADD:0]gray, nbinary;
  wire [ADD:0]binary;

  
  assign binary=((~fullt)&&w_en)?(nbinary+1):nbinary; //Increment
     
  assign fullt=(wptr=={~req_r[ADD],req_r[ADD-1:0]});
  
  always@(posedge wclk, negedge wrst)
    begin
      if(~wrst) begin
        nbinary<=0;
        wptr<=0;
        wadd<=0;
      end
      else 
        begin
          nbinary<=binary;
          wptr<=(binary>>1)^binary;
          wadd<=binary[ADD-1:0];
        end
    end
  always@(posedge wclk, negedge wrst)
    begin
      if(~wrst)
        full<=0;
      else
        full<=fullt;
    end

endmodule

//Read Logic and empty condition
module read_logic(empty,rclk,rptr,req_w,radd, rrst, r_en);
  parameter ADD=3, DATA=8;
  input rclk, rrst, r_en;
  input [ADD:0]req_w;
  output reg empty;
  wire emptyt;
  output reg [ADD:0]rptr;
  output reg [ADD-1:0]radd;
  reg [ADD:0]gray, nbinary;
  wire [ADD:0]binary;

  
  assign binary=((~emptyt)&&r_en)?(nbinary+1):nbinary;
     
  assign emptyt=(rptr==req_w);
  
  always@(posedge rclk, negedge rrst)
    begin
      if(~rrst) begin
        nbinary<=0;
        rptr<=0;
        radd<=0;
      end
      else 
        begin
          nbinary<=binary;
          rptr<=(binary>>1)^binary;
          radd<=binary[ADD-1:0];
        end
    end
  always@(posedge rclk, negedge rrst)
    begin
      if(~rrst)
        empty<=0;
      else
        empty<=emptyt;
    end

endmodule


//Sync_write
module sync_write(req_w, wptr, rclk, rrst);
  parameter ADD=3;
  input rclk, rrst;
  input [ADD:0]wptr;
  output reg [ADD:0]req_w;
  reg [ADD:0]temp;
  always@(posedge rclk, negedge rrst)
    begin
      if(~rrst) begin
        req_w<=0;
        temp<=0;
      end
     else begin
        req_w<=temp;
        temp<=wptr;
     end
    end
endmodule

//Sync_read
module sync_read(req_r, rptr, wclk, wrst);
  parameter ADD=3;
  input wclk, wrst;
  input [ADD:0]rptr;
  output reg [ADD:0]req_r;
  reg [ADD:0]temp;
  always@(posedge wclk, negedge wrst)
    begin
      if(~wrst) begin
        req_r<=0;
        temp<=0;
      end
     else begin
        req_r<=temp;
        temp<=rptr;
     end
    end
endmodule





//TB---------------------------------------------------------------------------------------------------------------------------------------------------

module tb;
  
  Asynchronous_FIFO f11(full, empty, wclk, rclk, w_en, r_en, rdata, wdata, wrst, rrst);
  parameter ADD=3, DATA=8, DEPTH=1<<ADD;
  logic wrst, rrst, w_en, r_en, wclk, rclk;
  logic [DATA-1:0]wdata;
  logic full, empty;
  logic [DATA-1:0]rdata;
  
  always #4 wclk=~wclk;
  always #8 rclk=~rclk;
  
  initial
    begin
      wdata=1;
      wclk=0;
      rclk=0;
      wrst=1;
      r_en=1;
      w_en=1;
      rrst=1;
      #2 wrst=0;
      rrst=0;
      #10 wrst=1;
      rrst=1;
      repeat(15)
        begin
          @(posedge wclk);
          wdata=$urandom();
        end
      
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #200 $finish;
    end
endmodule
