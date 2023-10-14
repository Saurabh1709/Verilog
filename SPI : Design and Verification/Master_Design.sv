module spi(clk, rst, din, newd, sclk, mosi, cs);
  input clk, rst, newd;
  input [11:0]din;
  output reg sclk, mosi, cs;
  
  //////sclk from clk: slower: 40 tc = tsc, fsc = fc/40
  int countc = 0;
  int count=0;
  
  parameter idle=4'b0001, enable=4'b0010, send=4'b0100, comp=4'b1000;
  reg [3:0]state;
  
  always@(posedge clk) begin
    if(rst==1) begin
      countc <= 0;
      sclk <= 0;
    end
    
    else if(countc < 20) begin
      countc = countc + 1;
    end
    
    else begin
      sclk <= ~sclk;
      countc <= 0;
    end
    
  end
  
  reg [11:0]temp;
  
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
          if(count<12) begin
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
///////////////////////////////////////////////////////
interface intf_design;
  logic clk, rst, newd;
  logic [11:0]din;
  logic sclk, mosi, cs;
endinterface
