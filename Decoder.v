//Decoder
module decoder(o, i, s);
  input i;
  input [1:0]s;
  output reg [3:0]o;
  always@(*)
    case(s)
      
        0: o = 4'd0;
        1: o = 4'd1;
        2: o = 4'd2;
        3: o = 4'd3;
        default: o = 4'hz;
    endcase
endmodule


//TB
module tb;
  decoder aa(o, i, s);
  logic [1:0]s;
  logic [3:0]o;
  logic i;
  initial
    begin
      i = 1;
      repeat(5)
        begin
          s = $urandom();
          #5;
        end
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
