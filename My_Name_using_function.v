module tb;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  always
    begin
      intro();
    end
endmodule

function intro();
  begin
    $display("Hey! Saurabh");
  end
endfunction
