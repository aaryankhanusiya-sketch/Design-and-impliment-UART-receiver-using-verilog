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
