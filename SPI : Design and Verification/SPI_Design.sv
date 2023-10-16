module spi_slave(mosi, cs, sclk, done, dout);
  input mosi, sclk, cs;
  output reg [7:0]dout;
  output reg done;

  int count=0;

  typedef enum bit {tx = 1'b0, rx = 1'b1} state_type;
  state_type state = tx;
 
  
  always@(posedge sclk) begin
    
      case(state)
        tx: begin
          done<=0; //done always zero in tx state
          if(cs==0) begin
            state<=rx;
          end
          else state<=tx;
        end
        rx: begin
          if(count<=7) begin
            count<= count+1;
            dout<={mosi, dout[7:1]};
          end
          else begin
            count<=0;
            state<=tx;
            done<=1;
          end
        end
        default: state<= tx;
      endcase
   
  end
endmodule
///////////////////////////////////////

module spi_master(clk, rst, din, newd, sclk, mosi, cs);
  input clk, rst, newd;
  input [7:0]din;
  output reg sclk, mosi, cs;
  
  //////sclk from clk
  int countc = 0;
  int count=0;
 
  typedef enum bit {idle = 1'b0, send = 1'b1} state_type;
  state_type state = idle;
  
  always@(posedge clk) begin
    if(rst==1) begin
      countc <= 0;
      sclk <= 0;
    end
    
    else if(countc < 5) begin
      countc = countc + 1;
    end
    
    else begin
      sclk <= ~sclk;
      countc <= 0;
    end
    
  end
  
  reg [7:0]temp;
  
  always@(posedge sclk) begin
    if(rst==1) begin
      //count <=0;
      mosi <= 0;
      cs<=1;
    end
  
    else begin
      case(state)
        idle: begin
          if(newd==1) begin
            cs<=0;
            temp<=din;
            state<=send;
          end
          else begin
            state<=idle;
            temp<=0;
          end
         
        end
        
        send: begin
          if(count<8) begin
            count<=count+1;
            mosi <= temp[count];
          end
          else begin
            count<=0;
            state<=idle;
            cs<=1;
            mosi<=0;
          end
        end
        default: state<=idle;
      endcase
    end
  end
  
endmodule
////////////////////////////////////////////

module spi(clk, rst, din, newd, dout, done);
  input clk, rst, newd;
  input [7:0]din;
  output [7:0]dout;
  output done;
  wire mosi, cs, sclk;
  
  spi_master s0(clk, rst, din, newd, sclk, mosi, cs);
  spi_slave s1(mosi, cs, sclk, done, dout);
  
endmodule
////////////////////////////////////////////////
interface intf_design;
  logic clk, rst, newd;
  logic [7:0]din;
  logic [7:0]dout;
  logic done;
  logic sclk;
endinterface

