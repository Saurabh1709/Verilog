//Let's begin the test
module fork_join;
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      #100 $finish;
    end
  initial
    begin
      fork
        test1();
        test2();
        test3();
      join_any
      test4();
    end
endmodule

//Tasks
task test1();
  begin
    #5;
    $display("test1 ", $time);
  end
endtask

task test2();
  begin
    #10;
    $display("test2 ", $time);
  end
endtask

task test3();
  begin
    #15;
    $display("test3 ", $time);
  end
endtask

task test4();
  begin
    #5;
    $display("test4 ", $time);
  end
endtask
  
