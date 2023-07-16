module xorbitwise(a, b, o);  //8 bit xor module
  parameter n = 8;
  input [(n-1):0]a, b;
  output [(n-1):0]o;
  genvar i;
  generate for(i = 0; i < n; i++)
      begin 
        xorbit aa(a[i], b[i], o[i]);
      end
  endgenerate
endmodule

module xorbit(a, b, o);     //1 bit xor module
  input a, b;
  output o;
  xor xx1(o, a, b);
endmodule

//TB
module tb;
  parameter n = 8;
  logic [n-1:0]a, b, o;
  xorbitwise x11(a, b, o);
  initial
    begin
      a = 8'b1111111;
      b = 8'b1111111;
      #5 a = 8'b1111;
      b = 8'b0111;
      #5 a = 8'b0011;
      b = 8'b1011;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
