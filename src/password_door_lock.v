`timescale 1ns/1ps

module password_door_lock (
    input  wire clk,
    input  wire rst_n,
    input  wire serial_in,
    output reg  unlock
);

    reg [3:0] shift_reg;
    reg [1:0] bit_count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 4'b0000;
            bit_count <= 2'b00;
            unlock    <= 1'b0;
        end else begin
            shift_reg <= {shift_reg[2:0], serial_in};

            if (bit_count == 2'd3) begin
                bit_count <= 2'b00;
                unlock <= ({shift_reg[2:0], serial_in} == 4'b1011);
            end else begin
                bit_count <= bit_count + 1'b1;
                unlock <= 1'b0;
            end
        end
    end

endmodule
