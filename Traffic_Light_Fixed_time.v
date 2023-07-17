module TLC(c, colour, r);
  input c, r;
  output reg [2:0]colour;
  reg [1:0]light;

  always@(posedge c)
    begin
      if(r)
        light <= 2'b00;
      else
        case(light)
          0: light <= 2'b01;
          1: light <= 2'b10;
          2: light <= 3'b00;
          default: light <= 2'b00;
        endcase
    end
  always@(light)
    begin
      case(light)
        0: colour = 3'b001;
        1: colour = 3'b010;
        2: colour = 3'b100;
        default: colour = 3'b001;
      endcase
        
    end
endmodule


//TB
module tb;
  TLC ll(c, colour, r);
  logic c, r;
  logic [2:0]colour;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      c = 1'b0;
      r = 1'b1;
      #6 r = 1'b0;
    end
  always #5 c = ~c;
endmodule
