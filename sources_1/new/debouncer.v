`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 10:06:22
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module debouncer(
    
    input btn,
    input clk,
    input debouncedbtn_in,
    output reg debouncedbtn_out
    //output reg debouncedbtn_out

    );
     //rebounce code start >>>>>
               reg [31:0] debounceCount = 0;
               reg prevButtonState =0;
              
               reg buttonState = 0;
               
               reg prevStableState = 0; // previous debounced button state
               
               reg buttonCD = 0;
               reg [31:0] buttonCDCount = 0;
               
              
               
               // <<<<<
                // debounce >>>>
                 always @ (posedge clk) begin 
                             prevButtonState = buttonState;
                             buttonState = btn;
                             
                             if(prevButtonState != buttonState && buttonState != debouncedbtn_in) begin // only trigger the code if there is an attempt to change buttonState
                               debounceCount = 0;
                             end else begin
                                if(debounceCount <= 2439024) begin//2439024
                                  debounceCount <= debounceCount + 1;
                                end else begin
                                  debounceCount <= 0;
                                  prevStableState = debouncedbtn_in; // store the previous stable state of the button
                                  debouncedbtn_out = buttonState;  
                                                    
                                end
                             end 
                  end
                             
                       // debounce <<<<<<
    
endmodule
