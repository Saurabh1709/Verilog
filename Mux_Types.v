//Type 1
module mux (o, s, i);
  input [3:0]i;
  input [1:0]s;
  output o;
  assign o = i[s];
endmodule

//Type 2
module mux (o, s, i);
  input [3:0]i;
  input [1:0]s;
  output o;
  assign o = (s==2'b00)?i[0]:((s==2'b01)?i[1]:((s==2'b10)?i[2]:((s==2'b11)?i[3]:1'bz)));
endmodule

//TB
module tb;
  mux ss(o, s, i);
  logic [3:0]i;
  logic [1:0]s;
  logic o;
  initial
    begin
      i = 4'b1101;
      s = 2'b00;
      #2;
      for (int x= 0; x < 5; x++)
        begin
          s = $urandom_range(0, 2'b11);
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
