`timescale 1ns/1ps

module tb_password_door_lock;
    reg clk = 0;
    reg rst_n = 1;
    reg serial_in = 0;
    wire unlock;
    integer errors = 0;

    password_door_lock dut (
        .clk(clk), .rst_n(rst_n),
        .serial_in(serial_in), .unlock(unlock)
    );

    always #5 clk = ~clk;

    task send_bit(input reg b);
        begin
            serial_in = b;
            @(posedge clk);
            #2;
        end
    endtask

    task reset_dut;
        begin
            @(negedge clk);
            rst_n = 0;
            serial_in = 0;
            repeat (2) @(negedge clk);
            rst_n = 1;
        end
    endtask

    initial begin
        $dumpfile("results/password_door_lock.vcd");
        $dumpvars(0, tb_password_door_lock);

        reset_dut();

        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);

        if (unlock === 1'b1)
            $display("PASS: correct password 1011");
        else begin
            $display("FAIL: correct password 1011, unlock=%b", unlock);
            errors = errors + 1;
        end

        reset_dut();

        send_bit(1);
        send_bit(0);
        send_bit(0);
        send_bit(1);

        if (unlock === 1'b0)
            $display("PASS: incorrect password 1001 rejected");
        else begin
            $display("FAIL: incorrect password 1001, unlock=%b", unlock);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("SIMULATION PASS");
        else
            $display("SIMULATION FAIL: %0d error(s)", errors);

        $finish;
    end
endmodule
