`timescale 1ns/1ps

module top;
    reg clk = 0;
    reg rst = 1;
    wire [3:0] count;

    // Instantiate the DUT (your counter)
    counter uut (.clk(clk), .rst(rst), .count(count));

    // Generate Clock (Toggle every 10ns)
    always #10 clk = ~clk;

    initial begin
        $dumpfile("counter.vcd"); // Create waveform file
        $dumpvars(0, top);  // Dump all signals
        #5 rst = 0;  // Release reset after 5ns
        #200; // Run simulation for 200ns
        $finish;  // Stop simulation
    end
endmodule
