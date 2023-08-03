module Gray_counter(o1, o2, i);
  input [4:0]i;
  output reg [4:0]o1;
  wire [4:0]temp, temp1;
  reg [4:0]o;
  assign temp = o; 
  assign temp1 = temp + 1'b1;
  always@(i)
    begin
      o[4]=i[4];    //G2B
      o[3]=o[4]^i[3];
      o[2]=o[3]^i[2];
      o[1]=o[2]^i[1];
      o[0]=o[1]^i[0];
      $display(o);
    end
  always@(temp1)    //B2G
    begin
      o1[4]=temp1[4];
      o1[3]=temp1[4]^temp1[3];
      o1[2]=temp1[3]^temp1[2];
      o1[1]=temp1[2]^temp1[1];
      o1[0]=temp1[1]^temp1[0];
    end
  always@(o1)
    begin
      
    end
endmodule


//TB
module tb;
  Gray_counter hh(o1, i);
  logic [4:0]i, o1;
  initial
    begin
      i = 5'b00011;
      #2;
      i = 5'b00010;
      
    end
  initial
    begin
      
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #20 $finish;
    end
endmodule
