module uart_transmitter (
    input clk,
    input reset,
    input start,
    input [7:0] data_in,
    output reg tx,
    output reg busy
);

    reg [7:0] data;
    reg [3:0] bit_count;
    reg [2:0] baud_count;

    // Number of clock cycles for one UART bit
    parameter BAUD_COUNT = 4;

    always @(posedge clk) begin

        if (reset) begin
            tx <= 1'b1;
            busy <= 1'b0;
            data <= 8'b0;
            bit_count <= 4'd0;
            baud_count <= 3'd0;
        end

        else begin

            if (!busy) begin

                // Start transmission
                if (start) begin
                    data <= data_in;
                    busy <= 1'b1;
                    bit_count <= 4'd0;
                    baud_count <= 3'd0;

                    // Start bit
                    tx <= 1'b0;
                end

                else begin
                    tx <= 1'b1;
                end

            end

            else begin

                // Baud counter
                if (baud_count == BAUD_COUNT - 1) begin

                    baud_count <= 3'd0;

                    if (bit_count < 8) begin

                        // Send data bits LSB first
                        tx <= data[bit_count];
                        bit_count <= bit_count + 1;

                    end

                    else begin

                        // Stop bit
                        tx <= 1'b1;
                        busy <= 1'b0;
                    end

                end

                else begin
                    baud_count <= baud_count + 1;
                end

            end

        end

    end

endmodule