module uart_rx(clk, reset, rxd, rx_done, data_out, tick);
  input clk, reset, rxd;
  output [7:0] data_out;
  output rx_done;
  output tick;
  
  reg [2:0] ps, ns;
  reg [7:0] sbuf_reg, sbuf_next;
  reg [2:0] count_reg, count_next;
  wire tick;
  reg [11:0] q;
  wire [11:0] q_next;
  reg rx_done;
  
  
  
  localparam idle = 2'b00;
  localparam start = 2'b01;
  localparam trans = 2'b10;
  localparam stop = 2'b11;

  
  
  
  
  //state machine
  
  always@(posedge clk)
    begin 
      if (reset)
        begin
          ps <= idle;
          sbuf_reg <= 0;
          count_reg <= 0;
        end
      else
        begin
          ps <= ns;
          sbuf_reg <= sbuf_next;
          count_reg <= count_next;
        end
    end
  
  always@(*)
    
    begin 
      
      ns = ps;
      sbuf_next = sbuf_reg;
      count_next = count_reg;
      
      case(ps)
        
        idle: 
          begin
            $display($time, "--- idle state");
            if(rxd == 0)
              begin 
                ns <= start;
                $display($time, "--- idle to start");
                rx_done <= 0;
              end
          end
        
        start:
          begin
            
            $display($time, "--- start state");
            if(tick)
              begin
                ns <= trans;
                $display($time, "--- start to trans");
                count_next <= 0;
              end
          end
        
        trans: 
          begin 
            $display($time, "--- trans state");
            if(tick)
              begin
                sbuf_next <= {rxd, sbuf_reg[7:1]};
                if(count_reg == 7)
                  begin
                    ns <= stop;
                    $display($time, "---- trans to stop");
                  end
                else
                  count_next <= count_reg + 1;
              end
          end
        
         stop:
           begin 
             $display($time, "--- stop state");
             if(tick)
               begin 
                 $display($time, "--- stop to idle");
                 ns = idle;
                 rx_done <= 1;
               end
           end
        
        default: ns = idle;
      endcase
    end
  
  assign data_out = sbuf_reg;
  
  
  baud_gen baud_gen_inst (
    .clk(clk),
    .reset(reset),
    .tick(tick)
  );
  
endmodule
