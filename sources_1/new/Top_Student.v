`timescale 1ns / 1ps
    
    //////////////////////////////////////////////////////////////////////////////////
    //
    //  FILL IN THE FOLLOWING INFORMATION:
    //  STUDENT A NAME: 
    //  STUDENT B NAME:
    //  STUDENT C NAME: 
    //  STUDENT D NAME:  
    //
    //////////////////////////////////////////////////////////////////////////////////
    
    module Top_Student (
        // Delete this comment and include Basys3 inputs and outputs here
         input clock,               //system clock
      //   input [11:0] DATA1,     // 12-bit digital data 1
       //  input [11:0] DATA2,     // 12-bit digital data 2
     //    input RST,              // asynchronous reset
    //     output D1,              // PmodDA2 Pin2 (serial data 1)
    //     output D2,              // PmodDA2 Pin3 (serial data 2)
    //     output CLK_OUT,         // PmodDA2 Pin4 (serial clock)
    //     output nSYNC,           // PmodDA2 Pin1 (chip select)
       //  output DONE,             // done signal
         output [3:0] JA, // 
         input btnC,
         output [15:0] led
          
          
        );
        
        // >>>>>>>>> clock stuff start
            reg [11:0] audio_out = 12'b000000000000;
            reg [25:0] clk50Mcount = 0; //
            reg clk50M = 0;  //
            reg [25:0] clk20kcount = 0; // 
            reg clk20k = 0;   
            reg [25:0] clk190count = 0; // 131579
            reg clk190 = 0;   
            reg [25:0] clk380count = 0; // 131579
            reg clk380 = 0;
            reg beepState = 0;
            reg [28:0] beepCount = 0;
            reg beepSetting = 1'b0;
            reg state = 0;
            
            reg clkCustom = 0;
            reg [25:0] clkCustomMax  = 131579;
            reg [25:0] clkCustomCount  = 0;
            reg [11:0] customVol = 12'b111111111111; //12'b
            
            //>>>debounce
                reg debouncedButton = 0;
            
            
            // << debounce
            
            // <<<<<<<,,clock stuff end
            
            
            
            // data registers >>>>>>>>>>>>>>>>>>>
                reg [7:0] selectedNote = 8'b10000000; // bit position is the note
                reg [7:0] playingNote =8'b10000000; //
                reg [25:0] note0tone = 305810; // use integer here. goes from 0 (silent), 1(do), 2(re), 3(mi) .... 8(do again)
                reg [25:0] note1tone = 272479; // use integer here. 
                reg [25:0] note2tone = 242718; // use integer here. 
                reg [25:0] note3tone = 229042; // use integer here. 
                reg [25:0] note4tone = 204081; // use integer here. 
                reg [25:0] note5tone = 181818; // use integer here. 
                reg [25:0] note6tone = 161969; // use integer here. 
                reg [25:0] note7tone = 152905; // use integer here. 
                reg [31:0] BPMCount = 0;
                reg [31:0] BPMMaxCount = 50000000; // 0.5secs
                
                
                
             
                
            
            
            // data registers <<<<<<<<<<<<<<<<
           
            
            
        
//        wire debouncedButtonWire;
//         debouncer debounce (
//                           .btn(btnC),
//                           .clk(clock),
//                           .debouncedbtn_in(debouncedButton),
//                           .debouncedbtn_out(debouncedButton)
//                          );
      
        always @ (posedge clock) begin 
        
       
               // >>>> cycle thru notes start
               //cycle thru playingNote
              if (BPMCount >= BPMMaxCount) begin // check if counter reached maximum count
                 BPMCount = 0;
                 
               if (playingNote == 8'b10000000) begin  
                     playingNote = 8'b01000000;
                     clkCustomMax = note1tone;
                 end else if (playingNote == 8'b01000000) begin 
                     playingNote = 8'b00100000;
                     clkCustomMax = note2tone;
                 end else if (playingNote == 8'b00100000) begin 
                     playingNote = 8'b00010000;  
                     clkCustomMax = note3tone;          
                 end else if (playingNote == 8'b00010000) begin 
                     playingNote = 8'b00001000;
                     clkCustomMax = note4tone;
                 end else if (playingNote == 8'b00001000) begin 
                     playingNote = 8'b00000100;
                     clkCustomMax = note5tone;
                 end else if (playingNote == 8'b00000100) begin 
                     playingNote = 8'b00000010;
                     clkCustomMax = note6tone;
                 end else if (playingNote == 8'b00000010) begin 
                     playingNote = 8'b00000001;
                     clkCustomMax = note7tone;
                 end else if (playingNote == 8'b00000001) begin 
                     playingNote = 8'b10000000;
                     clkCustomMax = note0tone;
                 end
            end
              BPMCount <= BPMCount + 1; // increment counter
            
              // <<<< cycle thru notes end
               
               //>>>>>>>>>>>>>play note start
               // look at playingnote, depending on value, read notextone and change clkCustomCount
//               if(playingNote == 3'b100) begin
//                    clkCustomMax = note0tone;
//               end else if(playingNote == 3'b010) begin
//                    clkCustomMax = note1tone;
//               end else if(playingNote == 3'b001) begin
//                    clkCustomMax = note2tone;
//               end
                     
               
               //<<<<<<<<<play note end
               
               
               
               
       // << 
            
               
               
//               if(debouncedButton == 1) begin
//                  beepState = 1;
//                  beepCount = 0;
//                 // audio_out[11] <= 0;
                
//               //   100000000  
//               end
               
              
               
//               if(beepState == 1) begin
//                    beepCount <= beepCount + 1;
                    
                    
//                    if(beepCount >= 100000000)begin
//                        beepState <= 0;
//                        audio_out[11] <= 0;
//                    end
                
               
//               end
               
               
               clk50Mcount <= clk50Mcount + 1;
               clk20kcount <= clk20kcount + 1; 
           
               
               
               
                if (clk50Mcount >= 1) begin 
                           
                           clk50M <= ~clk50M;
                           clk50Mcount <=  0;
                end 
                
                if (clk20kcount >= 2500) begin 
                             clk20k <= ~clk20k;
                             clk20kcount <=  0;
                end 
               
                 
                  clkCustomCount <= clkCustomCount + 1;
                  if(clkCustomCount >= clkCustomMax)begin
                    clkCustom <= ~clkCustom;
                    clkCustomCount <= 0;
                    audio_out[11:0] <= audio_out[11:0] ^ 12'b100000000001;

                  
                  end
                  
                  
      
                
                
                
               
        end
        
        
        Audio_Output audio_output (
            .CLK(clk50M), // -- System Clock (50MHz)  
            .START(clk20k), // -- Sampling clock 20kHz
            .DATA1(audio_out[11:0]), //   12-bit digital data1
            .DATA2(audio_out[11:0]), // 12 bit digital data 2
            .RST(0), // input reset
            .D1(JA[1]), // -- PmodDA2 Pin2 (Serial data1)
            .D2(JA[2]), // -- PmodDA2 Pin3 (Serial data2)
            .CLK_OUT(JA[3]), //  -- PmodDA2 Pin4 (Serial Clock)
            .nSYNC(JA[0]), //  -- PmodDA2 Pin1 (Chip Select)
            .DONE(0)
        );
    
        // Delete this comment and write your codes and instantiations here
    
    endmodule