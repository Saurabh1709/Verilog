module fifo(rst, clk, din, dout, rd, wr, full, empty);
  input rst, clk, wr, rd;
  input [7:0]din;
  output full, empty;
  output reg [7:0]dout;
  
  reg [3:0]rdptr=0;
  reg [3:0]wrptr=0;
  reg [4:0]count=0;
  reg [7:0]mem[15:0];
  
  always@(posedge clk or posedge rst) begin
    if(rst==1) begin
      wrptr <= 0;
      rdptr <= 0;
      count <= 0;
    end
    else begin
      if(wr && !full) begin
        mem[wrptr] <= din;
        wrptr <= wrptr + 1;
        count <= count + 1;
      end
      else if(rd && !empty) begin
        dout <= mem[rdptr];
        rdptr <= rdptr + 1;
        count <= count - 1;
      end
    end
  end
  assign empty = (count==0)?1:0;
  assign full = (count==16)?1:0;
endmodule

  
