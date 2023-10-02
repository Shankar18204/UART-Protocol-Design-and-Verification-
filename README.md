# UART-Protocol-Design-and-Verification-


## Basic Description
A UART, or **Universal Asynchronous Receiver/Transmitter**, comprises two key components: a transmitter and a receiver. The transmitter functions as a specialized shift register, loading data in parallel and then sequentially transmitting it at a specific rate, one bit at a time. In contrast, the receiver accepts incoming data bit by bit and reconstructs the original data stream. When the serial line is in an idle state, it is set to 1. Since the protocol is asynchronouse, to establish successful connection both the transmitter and receiver need to operate at the same baud rate. Baud rate determines the speed at which bits are transferred through the serial connection. To generate this baud rate, you have an additional component which is the **Baud Rate Generator**. 

## How it works
The transmission process commences with a start bit, which has a value of 0, followed by the data bits. Finally, the transmission concludes with stop bits, which are set to 1. The number of data bits can be 6, 7, or 8, while the number of stop bits can be 1, 1.5, or 2. You could also chose to add a parity bit after the stop bit for error detection. 
