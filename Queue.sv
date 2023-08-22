module tb;
  int qu[$]={1, 3, 9};
  int quu[$]={1, 3, 6};
  initial begin
    $display("Equal? : %0d", qu[0:1]==quu[0:1]);
    $display("%0p", qu);
    qu.push_front(2);
    qu.push_front(100);
    $display("%0p", qu);
    qu.push_back(25);
    $display("[%0p] and size: %0d", qu, $size(qu));
    qu.insert(2, 3);
    $display("%0p", qu);
    qu.pop_front();
    $display("%0p", qu);
    qu.delete(3);
    $display("%0p", qu);
  end
endmodule
