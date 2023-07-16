module priorityencoder(o, i);
  input [3:0]i;
  output reg [1:0]o;
  always@(*)
    begin
      if(i[3])
        o = 2'b11;
      else if(i[2])
        o = 2'b10;
      else if(i[1])
        o = 2'b01;
      else if(i[0])
        o = 2'b00;
      else
        o = 2'bz;
        
    end
      
endmodule


//TB
module tb;
  priorityencoder ss(o, i);
  logic [3:0]i;
  logic [1:0]o;
  initial
    begin
      repeat(5)
        begin
          i = $urandom_range(0, 4'b1111);
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
