<img width="891" height="555" alt="Screenshot 2025-08-12 155634" src="https://github.com/user-attachments/assets/47d2a338-3f56-437e-a780-7cfa3ee6ba3e" />**Project Completed:** november 2024  
**Uploaded to GitHub:** August 2025

Design and Implement UART Receiver using Verilog
📌 Project Overview
This project implements an 8-bit UART Receiver using Verilog HDL on the Altera Cyclone II FPGA board.
The received UART data is tested with a UART Transmitter implemented on the STM Discovery board.

🛠 Tools & Technologies
Language: Verilog HDL

FPGA Board: Altera Cyclone II (EP2C35F672C6)

Software: Quartus II 13.0 SP1 Web Edition

Testing Board: STM32 Discovery Board

⚙ Features
8-bit UART data reception

Configurable baud rate

Start, data, and stop bit detection

Hardware testing with STM32 UART TX

📂 Files in this Repository
uart8receiver1.v → Main Verilog code for UART Receiver

implementation photo.jpeg → FPGA hardware setup photo

implementation photo-2.jpeg → UART test connection photo

🚀 How to Use
Open uart8receiver1.v in Quartus II.

Compile the project and assign correct FPGA pins for RX.

Generate .sof file and program Cyclone II via USB Blaster.

Connect STM32 TX pin to FPGA RX pin.

Send UART data from STM32 and observe on FPGA output.


What is UART?
“UART” stands for Universal Asynchronous receiver-transmitter. It is a hardware peripheral that is present inside a microcontroller. The function of UART is to convert the incoming and outgoing data into the serial binary stream. An 8-bit serial data received from the peripheral device is converted into the parallel form using serial to parallel conversion and parallel data received from the CPU is converted using serial to parallel conversion. This data is present in modulating form and transmits at a defined baud rate.

Why UART is used?
Protocols like SPI (serial peripheral interface) and USB (Universal Serial Bus) are used for fast communication. When the high-speed data transfer is not required UART is used. It is a cheap communication device with a single transmitter/receiver. It requires a single wire for transmitting the data and another wire for receiving.

UART Interface- <img width="799" height="411" alt="UART Interface" src="https://github.com/user-attachments/assets/1cf73506-ef81-422a-890d-f4860c1cb1f4" />

It can be interfaced with a PC (personal computer) using an RS232-TTL converter or USB-TTL converter. The common thing between RS232 and UART is they both don’t require a clock to transmit and receive data. The Uart frame consists of 1 start bit, 1 or 2 stop bits and a parity bit for serial data transfer.

Block Diagram
The UART consists of the following core components. They are the transmitter and receiver. The transmitter consists of the Transmit hold register, Transmit shift register, and control logic. Similarly, the receiver consists of a Receive hold register, Receiver shift register, and control logic. In common, both the transmitter and receiver are provided with a baud rate generator.

Block diagram - <img width="891" height="555" alt="UART Block diagram" src="https://github.com/user-attachments/assets/1b9de61e-d208-44e1-abad-62a0867f4420" />

The baud rate generator generates the speed at which the transmitter and receiver have to send/receive the data. The Transmit hold register contains the data byte to be transmitted. The transmit shift register and receiver shift register shift the bits to the left or right until a byte of data is sent/received.

In addition to these, a read or write control logic is provided to tell when to read/write. The baud rate generator generates speeds ranging from 110 bps (bits per second) to 230400. Mostly, microcontrollers come up with higher baud rates such as 115200 and 57600 for faster data transfer. Devices like GPS and GSM use slower baud rates in 4800 and 9600.

Protocol Format
The UART starts the communication with a start bit ‘0’. The start bit initiates the transfer of serial data and stop bit ends the data transaction.
<img width="1165" height="326" alt="Receiver protocol format" src="https://github.com/user-attachments/assets/3ac633d2-d9dd-4884-a03a-dd20263c08c7" />
It is also provided with a parity bit (even or odd). Even parity bit is represented by ‘0’ (even number of 1’s) and the odd parity bit is represented by ‘1’ (odd number of 1’s).

Reception
During the reception, the RxD line (Receiver) is used for receiving the data.

<img width="1207" height="285" alt="Receive frame" src="https://github.com/user-attachments/assets/1c914118-f914-4b16-b9da-d5445d46dc0f" />
<img width="1165" height="326" alt="Receiver protocol format" src="https://github.com/user-attachments/assets/6cb977b9-5791-4a27-80a4-0d8113bbd217" />

Example of UART interfacing
This example demonstrates the interfacing of ESP8266 UART with MAX232. But, before I jump into the details of interfacing, let me share the pin details of the Max232 driver.

<img width="647" height="637" alt="MAX232 PINOUT" src="https://github.com/user-attachments/assets/273d4f2a-3b00-4a43-ae9c-73ef6bd51361" />
MAX232 IC is powered up by 5V supply which includes a capacitive voltage generator to drive 232 level voltages. It comes with dual transmitters also called the driver (TIN, TOUT) and receivers (RIN and ROUT).

Here, I have used ESP8266 (32-bit microcontroller) which has inbuilt UART. The communication can be done with ESP8266 using AT commands via RS232 to TTL level converter (MAX232). The below figure shows the connection of ESP8266 with PC (personal computer).











