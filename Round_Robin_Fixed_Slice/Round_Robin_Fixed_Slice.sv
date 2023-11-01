
module round_robin(gnt, req, c, r);
  input [3:0]req;
  input c, r;
  output reg [3:0]gnt;
  reg [2:0]ps, ns;
  parameter si=3'b000, s0=3'b001, s1=3'b010, s2=3'b011, s3=3'b100;
  always@(posedge c)
    begin
      if(r)
        ps <= 0;
      else
        ps <= ns;        //Sequential block
    end
  always@(ps, req)      //State assignment:combinational circuit
    begin
      if(r)
        begin
          gnt=4'b0000;
          ns=si;
        end
      case(ps)
          si: begin
            if(req[0])
              begin
                ns=s0;
                
              end
            else if(req[1])
              begin
                ns=s1;
                
              end
            else if(req[2])
              begin
                ns=s2;
               
              end
            else if(req[3])
              begin
                ns=s3;
                
              end
            else
              begin
                ns=si;
                
              end
          end
        
        s0: begin
          if(req[1])
              begin
                ns=s1;
               
              end
          else if(req[2])
              begin
                ns=s2;
               
              end
          else if(req[3])
              begin
                ns=s3;
                
              end
          else if(req[0])
              begin
                ns=s0;
                
              end
            else
              begin
                ns=si;
                
              end
          end
        
        s1: begin
          if(req[2])
              begin
                ns=s2;
                
              end
          else if(req[3])
              begin
                ns=s3;
               
              end
          else if(req[0])
              begin
                ns=s0;
                
              end
          else if(req[1])
              begin
                ns=s1;
                
              end
            else
              begin
                ns=si;
                
              end
          end
        
        s2: begin
          if(req[3])
              begin
                ns=s3;
                
              end
          else if(req[0])
              begin
                ns=s0;
                
              end
          else if(req[1])
              begin
                ns=s1;
                
              end
          else if(req[2])
              begin
                ns=s2;
                
              end
            else
              begin
                ns=si;
               
              end
          end
        
        s3: begin
          if(req[0])
              begin
                ns=s0;
                
              end
          else if(req[1])
              begin
                ns=s1;
                
              end
          else if(req[2])
              begin
                ns=s2;
                
              end
          else if(req[3])
              begin
                ns=s3;
                
              end
            else
              begin
                ns=si;
                
              end
          end
        
        default: begin
          if(req[0])
              begin
                ns=s0;
                
              end
          else if(req[1])
              begin
                ns=s1;
                
              end
          else if(req[2])
              begin
                ns=s2;
                
              end
          else if(req[3])
              begin
                ns=s3;
                
              end
            else
              begin
                ns=si;
                
              end
          end
      endcase
      
    end
  always@(ps)
    begin
      case(ps)
        si: gnt= 4'b0000;
        s0: gnt= 4'b0001;
        s1: gnt= 4'b0010;
        s2: gnt= 4'b0100;
        s3: gnt= 4'b1000;
        default: gnt= 4'b0000;
      endcase
    end
endmodule




//TB
module tb;
  logic [3:0]req;
  logic c, r;
  logic [3:0]gnt;
  round_robin dd(gnt, req, c, r);
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
      req = 4'b1000;
      #6 r = 1'b0;
      for(int i=0;i<10;i++)
        begin
          req=$urandom_range(0, 4'hf);
          #5;
        end
    end
  always #5 c = ~c;
endmodule
