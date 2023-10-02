module tx_test;
  reg clk, reset, tx_start;
  reg [7:0] data_in;
  wire txd, tx_done;
  
  uart_tx f(clk, reset, tx_start, data_in, txd, tx_done);
  
  initial begin 
    clk = 0;
    reset = 1;
    #20 reset = 0;
    #40 tx_start = 1;
    data_in = 8'haa; // 1010_1010
    #500000 
    $finish;
  end
  
  always #10 clk = ~clk; 
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(2,tx_test);
  end
endmodule 
