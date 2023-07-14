module barrelshifter(s,a,y);           //Barrel shifter
input [1:0]s;
input [3:0]a;
output [3:0]y;

  mux F1(a[3],a[0],a[1],a[2],s,y[3]);
  mux F2(a[2],a[3],a[0],a[1],s,y[2]);
  mux F3(a[1],a[2],a[3],a[0],s,y[1]);
  mux F4(a[0],a[1],a[2],a[3],s, y[0]);
endmodule




module mux(a, b, c, d, s, o);         //4x1 MUX
  input a, b, c, d;
  input [1:0]s;
  output reg o;
  always@(a, b, c, d, s)
    begin
      case(s)
        0: o = a;
        1: o = b;
        2: o = c;
        3: o = d;
        default: o = o;
      endcase
    end
  
endmodule





//TB
module tb;
  barrelshifter tb0(s,a,y);
  logic [3:0]a, y;
  logic [1:0]s;
  initial
    begin
      a = 4'b1100;
      s = 2'b00;
      #5 s = 2'b10;
      #5 s = 2'b11;
      #5 s = 2'b10;
      #5 s = 2'b11;
      
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule



