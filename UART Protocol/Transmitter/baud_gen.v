module baud_gen(clk, reset,  tick);
  input clk, reset;
  //output [11:0]q; 
  output tick;
  
  wire clk, reset;
  reg [11:0] q;
  wire tick;
  wire [11:0] q_next;
  
  always@(posedge clk)
    begin 
      if(reset)
        q = 0;
      else 
        q = q_next;
    end 
  
  assign q_next = (q == 2604) ? 0 :(q + 1);
  assign tick = (q == 2604)? 1 : 0;
endmodule 
