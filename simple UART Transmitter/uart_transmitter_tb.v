`timescale 1ns/1ps

module uart_transmitter_tb;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] data_in;

    wire tx;
    wire busy;

    // Connect UART transmitter
    uart_transmitter uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Create waveform file
        $dumpfile("output.vcd");
        $dumpvars(0, uart_transmitter_tb);

        // Initial values
        clk = 0;
        reset = 1;
        start = 0;
        data_in = 8'b00000000;

        #20;

        // Release reset
        reset = 0;

        // Send data 10101010
        data_in = 8'b10101010;
        start = 1;

        #10;

        start = 0;

        // Wait for complete transmission
        #450;

        $finish;

    end

endmodule