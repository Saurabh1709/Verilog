module binary_gray(g, b);
  input [3:0]b;
  output [3:0]g;
  assign g[3] = b[3]; 
  genvar i;
  generate
    for(i=0; i<3; i++)
      begin
        xor x0(g[i], b[i], b[i+1]);
      end
  endgenerate
endmodule


//TB
module tb;
  binary_gray aa(g, b);
  logic [3:0]g, b;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      for(int i=0; i<5; i++)
        begin
          b = $urandom_range(0, 4'hf);
          #4;
        end
     
    end
endmodule
