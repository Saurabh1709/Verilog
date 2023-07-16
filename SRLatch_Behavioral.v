//SR Latch
module srlatch(q, en, rst, s, r);
  input en, s, r, rst;
  output reg q;
  always@(*)
    begin
      if(rst)
        begin
        q = 0;
        end
      else if(en)
        begin
          case({s,r})
            2'b00: q = q;
            2'b01: q = 1'b0;
            2'b10: q = 1'b1;
            2'b11: q = 1'bz;
            default: q = q;
          endcase
        end
           else
             begin
             q = q;
             end  
    end
endmodule


//TB
module tb;
  srlatch ss(q, en, rst, s, r);
  logic en, s, r, rst, q;
  initial
    begin
      en = 1'b1;
      s = 1'b0;
      r = 1'b1;
      rst = 1'b1;
      #4;
      s = 1'b1;
      r = 1'b0;
      rst = 1'b0;
      #4;
      en = 1'b0;
      #1;
      s = 1'b0;
      r = 1'b0;
      #4;
      en = 1'b1;
      #1;
      s = 1'b1;
      r = 1'b1;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
