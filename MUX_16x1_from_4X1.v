module muxer(q, s, i);        //16 to 1 using 4 to 1
  input [15:0]i;
  input [3:0]s;
  output q;
  wire [3:0]a;
  mux a1(a[0], s[1:0] ,i[3:0]);
  mux a2(a[1], s[1:0] ,i[7:4]);
  mux a3(a[2], s[1:0] ,i[11:8]);
  mux a4(a[3], s[1:0] ,i[15:12]);
  mux a5(q, s[3:2], a);
endmodule


module mux(q, s, i);       //4 to 1 mux
  input [3:0]i;
  input [1:0]s;
  output q;
  assign q = i[s];
endmodule
