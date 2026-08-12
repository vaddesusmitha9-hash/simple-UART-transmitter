# Simple UART Transmitter

## Description

This project implements a simple UART Transmitter using Verilog HDL.

The UART transmitter sends 8-bit data serially, one bit at a time.

The UART frame contains:

- 1 Start bit
- 8 Data bits
- 1 Stop bit

The data is transmitted using the `tx` output.

## UART Frame Format

The frame is:

    Start Bit + 8 Data Bits + Stop Bit

The start bit is `0`.

The data is sent from LSB to MSB.

The stop bit is `1`.

Example for data `10101010`:

    0 0 1 0 1 0 1 0 1 1
    ↑ ↑                 ↑
    Start               Stop

## Inputs

| Input | Description |
|------|-------------|
| `clk` | Clock signal |
| `reset` | Resets the transmitter |
| `start` | Starts transmission |
| `data_in` | 8-bit data to transmit |

## Outputs

| Output | Description |
|------|-------------|
| `tx` | Serial UART output |
| `busy` | 1 while data is being transmitted |

## Working

When `start = 1`, the transmitter loads the 8-bit data.

The transmitter then sends:

    Start bit → Data bits → Stop bit

The data is transmitted from the least significant bit first.

## Files

- `uart_transmitter.v` - Main Verilog code
- `uart_transmitter_tb.v` - Testbench
- `output.vcd` - Simulation waveform
- `README.md` - Project documentation

## Simulation Settings

For simple simulation:

- Clock = 10 ns
- Baud counter = 4 clock cycles per bit

This small value is used only to make simulation faster and easier.

## How to Run

Compile:

    iverilog -o uart_sim uart_transmitter.v uart_transmitter_tb.v

Run:

    vvp uart_sim

Open waveform:

    gtkwave output.vcd

## Expected Result

When `start` is activated, the transmitter sends the UART frame serially.

The `busy` signal becomes `1` during transmission and returns to `0` after the frame is complete.

## Conclusion

The Simple UART Transmitter successfully converts 8-bit parallel data into serial UART data.
