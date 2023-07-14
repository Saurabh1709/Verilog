module bcd_sub(a,b,s,cout);
input [3:0]a,b;
output reg [3:0]s;
output reg cout;
reg [3:0]new_b;
  reg [4:0]new_s;
always@(a,b)
 begin
    new_b=10-b;         //10's complement of input
    new_s=a+new_b;
    if(temp_s>9)
     begin
        cout=1;
        new_s=new_s+6;
        s=new_s[3:0];
     end
    else
     begin
        cout=0;
        s=new_s[3:0];
        s=10-s;               //10's complement as carry is zero
     end
 end
