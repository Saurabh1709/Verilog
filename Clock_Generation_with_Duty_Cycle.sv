`timescale 1 ns / 1 ps 
module tb;
  bit c=0;
  bit c1=0;
  real phase=0;
  real duty_cycle=0.333;
  real freq=100_000_000;  //seconds
  real ton, toff;
  real phasee;
  real temp;
 
  initial begin 
    temp= 1000_000_000.0 / (2.0*freq);
    $display(temp);
    while(1) begin
      #temp;
      c=1;
      #temp;
      c=0;
      
    end
  end
    
  task generator(input real phase, input real duty_cycle, input real freq, output reg phasee, output real ton, output real toff);
    begin
      ton=(1.0/freq)*duty_cycle*1000_000_000.0;
      toff=(1000_000_000.0/freq)-ton;
      phasee=phase;
      $display(ton);
      $display(toff);
    end
  endtask
  
  initial begin
    generator (phase, duty_cycle, freq, phasee, ton, toff);
    @(posedge c)
    #phasee;
    while(1) begin
      c1=1;
      #ton;
      c1=0;
      #toff;
    end
    
    
  end
  initial #100 $finish;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
