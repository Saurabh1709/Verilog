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


//Sync_Read


//Sync_write
