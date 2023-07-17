module paritycheck(o, i, c, r);  //Even Parity
  input i, r, c;
  output o;
  reg [1:0]state;
  parameter si = 2'b00, se=2'b01, so=2'b10;
  always@(posedge c)
    begin
      if(r)
        state <= si;
      else
        begin
          case(state)
            si: state<= i?so:se;
            se: state<= i?so:se;
            so: state<= i?se:so;
            default: state<=si;
          endcase
        end
    end
  assign o = (state == se)?1:0;
  
endmodule

//TB
module tb;
  paritycheck fsm(o, i, c, r);
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
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b0;
      @(negedge c)
      i = 1'b1;
      @(negedge c)
      i = 1'b1;
    end
  always #5 c = ~c;
endmodule
