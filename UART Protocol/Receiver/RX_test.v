module text_rx;
  
  reg clk = 0;
  reg reset, rxd;
  wire rx_done;
  wire [7:0] data_out;
  wire tick;
  
  uart_rx UUT (clk, reset, rxd, rx_done, data_out, tick);
  initial begin 
    
    clk = 0;
    reset = 1;
    #20 reset = 0;
    #20 rxd = 0;// start
    $display($time, "--- start bit ----");
    rdata(1);
    $display($time, "--- rdata 1 ----");
    rdata(0);
    $display($time, "--- rdata 2 ----");
    rdata(1);
    $display($time, "--- rdata 3 ----");
    rdata(0);
    $display($time, "--- rdata 4 ----");
    rdata(1);
    $display($time, "--- rdata 5 ----");
    rdata(0);
    $display($time, "--- rdata 6 ----");
    rdata(1);
    $display($time, "--- rdata 7 ----");
    rdata(0);
    $display($time, "--- rdata 8 ----");
    rdata(1);
    $display($time, "--- stop bit ----");
    
    #1000 $display($time, "---- data out = %h -----", data_out);
    #100000 $stop;
  end
  
  always #10 clk = ~clk; //T - 20ns/ 50MHz
  
  
  
  
  task rdata; 
    input inp;
    begin 
      @(posedge tick)
      begin
        rxd = inp;
        $display($time, "---- supply data ---");
      end
    end
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(2, text_rx);
  end
endmodule

