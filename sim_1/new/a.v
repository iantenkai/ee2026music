`timescale 1ns/1ps

module Top_Student_TB;

    // Inputs
    reg clock;
    reg btnC;

    // Outputs
    wire [3:0] JA;

    // Instantiate the module to be tested
    Top_Student dut (
        .clock(clock),
        .btnC(btnC),
        .JA(JA)
    );

    // Clock generator
    always #5 clock = ~clock;

    // Stimulus
    initial begin
        $dumpfile("Top_Student_TB.vcd");
        $dumpvars(0, Top_Student_TB);

        // Provide clock and button inputs
        clock = 0;
        btnC = 0;

        #1000 $finish;
    end

endmodule