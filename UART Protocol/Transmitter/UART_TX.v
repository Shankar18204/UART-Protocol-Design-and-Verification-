module uart_tx (clk, reset, tx_start, data_in, txd, tx_done);
  input clk, reset, tx_start;
  input [7:0] data_in;
  output txd, tx_done;
  
  
  reg tx_done;
  wire txd;
  
  reg[2:0] ps, ns;
  wire tick;
  reg [11:0] q;
  wire [11:0] q_next;
  reg [7:0] sbuf_reg, sbuf_next;
  reg [2:0] count_reg, count_next;
  reg tx_reg, tx_next;
  
  
  localparam idle = 2'b00;
  localparam start= 2'b01;
  localparam trans= 2'b10;
  localparam stop = 2'b11;
  
  
  
  
  
  always@(*) begin
    ns = ps;
    sbuf_next = sbuf_reg;
    count_next = count_reg;
    tx_next = tx_reg;
   
    case(ps)
       idle:
        begin
          
          $display($time, "---- idle state");
          tx_next = 1;
          tx_done = 0;
          if(tx_start == 1)
            begin
              ns <= start;
              $display($time,"---- idle to start");
            end
        end
      
       start:
        begin 
          $display($time, "---- start state");
          tx_next = 0;
          if(tick == 1)
            begin 
              sbuf_reg <= data_in;
              count_next <= 0;
              ns <= trans;
              $display($time, "---- start to trans");
            end
        end
      
       trans:
        begin 
          $display($time," ---- trans state");
          tx_next = sbuf_reg[0];
          if(tick == 1)
            begin 
              sbuf_next = sbuf_reg >> 1;
              if(count_reg == 7)
                begin 
                  ns = stop;
                  $display($time,"---- trans to stop");
                end
              else
                count_next = count_reg + 1;
            end
        end
      
       stop:
        begin
          $display($time, "---- stop state");
          tx_next <= 0;
          if(tick)
            begin
              tx_done = 1;
              ns =  idle;
        end
      end
      
      default: ns = idle; 
    endcase
  end
      
      always@(posedge clk) begin
        if(reset)
          begin 
            ps <= idle;
            sbuf_reg <= 0;
            count_reg <= 0;
            tx_reg <= 0;
          end
        else
          begin 
            ps <= ns;
          	sbuf_reg <= sbuf_next;
          	count_reg <= count_next;
          	tx_reg <= tx_next;
          end
      end
      assign txd = tx_reg;
      
      //baud rate generator
      
     baud_gen baud_gen_inst (
    .clk(clk),
    .reset(reset),
    .tick(tick)
  );
  
endmodule
        
      
      
           
        
    
