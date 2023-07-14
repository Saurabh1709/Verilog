module bcd_sub(a,b,s,cout);
input [3:0]a,b;
output reg [3:0]s;
output reg cout;
reg [3:0]new_b;
  reg [4:0]new_s;
always@(a,b)
 begin
    new_b = 10-b;         //10's complement of input
    new_s = a + new_b;      // a - b
   if(new_s>9)
     begin
        cout=1;
        new_s=new_s+6;
        s=new_s[3:0];
     end
    else
     begin
        cout=0;
        s=new_s[3:0];
       s=10-s;               //10's complement as carry is 0
     end
 end
endmodule




//TB
module TB;
reg [3:0]a,b;
wire [3:0]s;
wire cout;
bcd_sub B1(a,b,s,cout);
initial
 begin
    a=4'b0000; b=4'b0000;                
    #10 a=4'b0011; b=4'b0011;              
    #10 a=4'b0111; b=4'b1100;             
    #10 a=4'b1100; b=4'b1011;           
    #10 a=4'b1011; b=4'b1000;              
    #10 a=4'b0100; b=4'b0111;               
 end

 
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
endmodule
