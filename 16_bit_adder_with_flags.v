module adder(s, z,  c, p, o, a, b);        //16 bit adder with flags
  input [15:0]a, b;
  output s, z, c, p;
  wire [15:0]sum;
  wire co;
  assign {co,sum} = a + b;
  assign z = (sum == 0)? 1: 0;  //zero
  assign s = sum[15];           //sign
  assign c = co;               //carry
  assign p = ^sum;             //odd parity
  assign o = (~a[15])&(~b[15])&(sum[15]) | (a[15])&(b[15])&(~sum[15]);  //overflow(This is for BCD addition, can ignore here.)
endmodule
