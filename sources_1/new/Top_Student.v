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
            
            //page  start>>>
         
            
            
            //page end <<<<
            
            
            
            // data registers >>>>>>>>>>>>>>>>>>>
              reg [0:31] page_1 = 32'h17701349;
                      reg [0:31] page_2 = 32'h01234568;
                      reg [0:31] page_3 = 32'h87653210;
                      reg [0:31] page_4 = 32'h14602874;
                reg [31:0] selectedNote = 32'b10000000000000000000000000000000;
 // bit position is the note
                reg [31:0] playingNote = 32'b10000000000000000000000000000000;
                reg [31:0] BPMCount = 0;
                reg [31:0] BPMMaxCount = 50000000; // 0.5secs
                
                reg [3:0] currentToneCode = 0;
                reg [25:0] currentToneFreq = (currentToneCode == 0 ) ? 305810 : //do 0
                                             (currentToneCode == 1 ) ? 272479 : //re 1
                                             (currentToneCode == 2 ) ? 242718 : // mi 2 
                                             (currentToneCode == 3 ) ? 229042 : //fa 3 
                                             (currentToneCode == 4 ) ? 204081 : //so 4
                                             (currentToneCode == 5 ) ? 181818 : // la 5
                                             (currentToneCode == 6 ) ? 161969 : // ti 6
                                             (currentToneCode == 7 ) ? 152905 : // do 7
                                              3 ; // otherwise, mute
                                             
                                             
                
            
        always @ (posedge clock) begin 
        
       
               // >>>> cycle thru notes start
               //cycle thru playingNote
              if (BPMCount >= BPMMaxCount) begin // check if counter reached maximum count
                 BPMCount = 0;
                 
               if (playingNote == 32'b00000000000000000000000000000001) begin  
                     playingNote = 32'b10000000000000000000000000000000;
                     currentToneCode = page_1[0:3];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b10000000000000000000000000000000) begin 
                     playingNote = 32'b01000000000000000000000000000000;
                     currentToneCode = page_1[4:7];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b01000000000000000000000000000000) begin 
                     playingNote = 32'b00100000000000000000000000000000;
                     currentToneCode = page_1[8:11];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00100000000000000000000000000000) begin 
                     playingNote = 32'b00010000000000000000000000000000;
                     currentToneCode = page_1[12:15];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00010000000000000000000000000000) begin 
                     playingNote = 32'b00001000000000000000000000000000;
                     currentToneCode = page_1[16:19];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00001000000000000000000000000000) begin 
                     playingNote = 32'b00000100000000000000000000000000;
                     currentToneCode = page_1[20:23];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000100000000000000000000000000) begin 
                     playingNote = 32'b00000010000000000000000000000000;
                     currentToneCode = page_1[24:27];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000010000000000000000000000000) begin 
                     playingNote = 32'b00000001000000000000000000000000;
                     currentToneCode = page_2[0:3];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000001000000000000000000000000) begin 
                     playingNote = 32'b00000000100000000000000000000000;
                     currentToneCode = page_2[4:7];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000100000000000000000000000) begin 
                     playingNote = 32'b00000000010000000000000000000000;
                     currentToneCode = page_2[8:11];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000010000000000000000000000) begin 
                     playingNote = 32'b00000000001000000000000000000000;
                     currentToneCode = page_2[12:15];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000001000000000000000000000) begin 
                     playingNote = 32'b00000000000100000000000000000000;
                     currentToneCode = page_2[16:19];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000100000000000000000000) begin 
                     playingNote = 32'b00000000000010000000000000000000;
                     currentToneCode = page_2[20:23];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000010000000000000000000) begin 
                     playingNote = 32'b00000000000001000000000000000000;
                     currentToneCode = page_2[24:27];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000001000000000000000000) begin 
                     playingNote = 32'b00000000000000100000000000000000;
                     currentToneCode = page_2[28:31];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000100000000000000000) begin 
                     playingNote = 32'b00000000000000010000000000000000;
                     currentToneCode = page_3[0:3];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000010000000000000000) begin 
                     playingNote = 32'b00000000000000001000000000000000;
                     currentToneCode = page_3[4:7];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000001000000000000000) begin 
                     playingNote = 32'b00000000000000000100000000000000;
                     currentToneCode = page_3[8:11];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000100000000000000) begin 
                     playingNote = 32'b00000000000000000010000000000000;
                     currentToneCode = page_3[12:15];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000010000000000000) begin 
                     playingNote = 32'b00000000000000000001000000000000;
                     currentToneCode = page_3[16:19];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000001000000000000) begin 
                     playingNote = 32'b00000000000000000000100000000000;
                     currentToneCode = page_3[20:23];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000100000000000) begin 
                     playingNote = 32'b00000000000000000000010000000000;
                     currentToneCode = page_3[24:27];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000010000000000) begin 
                         playingNote = 32'b00000000000000000000001000000000;
                         currentToneCode = page_3[28:31];
                         clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000001000000000) begin 
                     playingNote = 32'b00000000000000000000000100000000;
                     currentToneCode = page_4[0:3];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000100000000) begin 
                     playingNote = 32'b00000000000000000000000010000000;
                     currentToneCode = page_4[4:7];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000010000000) begin 
                     playingNote = 32'b00000000000000000000000001000000;
                     currentToneCode = page_4[8:11];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000001000000) begin 
                     playingNote = 32'b00000000000000000000000000100000;
                     currentToneCode = page_4[12:15];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000000100000) begin 
                     playingNote = 32'b00000000000000000000000000010000;
                     currentToneCode = page_4[16:19];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000000010000) begin 
                     playingNote = 32'b00000000000000000000000000001000;
                     currentToneCode = page_4[20:23];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000000001000) begin 
                     playingNote = 32'b00000000000000000000000000000100;
                     currentToneCode = page_4[24:27];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000000000100) begin 
                     playingNote = 32'b00000000000000000000000000000010;
                     currentToneCode = page_4[28:31];
                     clkCustomMax = currentToneFreq;
                 end else if (playingNote == 32'b00000000000000000000000000000010) begin 
                     playingNote = 32'b00000000000000000000000000000001;
                     currentToneCode = page_4[28:31];
                     clkCustomMax = currentToneFreq;
                 end




            end
              BPMCount <= BPMCount + 1; // increment counter              
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