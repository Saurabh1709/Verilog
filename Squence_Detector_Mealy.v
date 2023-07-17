module seq_detector(o, i, c, r);
  input i, c, r;
  output reg o;
  reg [1:0]ps, ns;
  parameter si=2'b00, s0=2'b01, s1=2'b10, s2=2'b11;
  always@(posedge c)         //Sequential Block
    begin
      if(r)
        ps <= si;
      else
        ps <= ns;
    end
  always@(ps, i)              //Combinational Block
    begin
      case(ps)
        si: begin
          ns=i?si:s0;
          o =0;
        end
        s0: begin
          ns=i?s1:s0;
          o =0;
        end
        s1: begin
          ns=i?s2:s0;
          o =0;
        end
        s2: begin
          ns=i?si:s0;
          o =i?0:1;
        end
        default: begin
          ns=si;
          o=0;
        end  
      endcase
    end
endmodule



//TB
module tb;
  seq_detector ss(o, i, c, r);
  logic i, c, r, o;
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
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
    end
  always #5 c = ~c;
endmodule
