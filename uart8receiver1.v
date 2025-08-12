module uart8receiver (
    input wire clk,          // 50 MHz clock input
    input wire reset_n,      // Active low reset
    input wire rx,           // UART receive input
    output reg [7:0] rx_data,// 8-bit received data
    output reg rx_ready      // Indicates data received and ready to be read
);

    // Parameters
    localparam BAUD_RATE = 115200;
    localparam CLOCK_FREQ = 50000000;  // 50 MHz clock
    localparam BAUD_DIV = CLOCK_FREQ / BAUD_RATE;  // Baud rate divider

    localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    reg [1:0] state = IDLE;        // FSM state
    reg [9:0] shift_reg;           // Shift register to store incoming bits
    reg [15:0] baud_counter = 0;   // Baud rate counter
    reg [3:0] bit_index = 0;       // Bit counter to track the current bit

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= IDLE;
            rx_ready <= 0;
            baud_counter <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    rx_ready <= 0;
                    if (!rx) begin  // Detect start bit (low)
                        state <= START;
                        baud_counter <= 0;
                    end
                end

                START: begin
                    if (baud_counter < (BAUD_DIV / 2)) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        baud_counter <= 0;
                        state <= DATA;
                        bit_index <= 0;
                    end
                end

                DATA: begin
                    if (baud_counter < BAUD_DIV) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        baud_counter <= 0;
                        shift_reg[bit_index] <= rx;  // Sample the data bit
                        bit_index <= bit_index + 1;
                        if (bit_index == 7) begin
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    if (baud_counter < BAUD_DIV) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        baud_counter <= 0;
                        rx_data <= shift_reg[7:0];  // Store received data
                        rx_ready <= 1'b1;           // Data is ready to be read
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule