`timescale 1ns/100ps

module tb_clock_divider();

    localparam T=5;

    logic   clk;
    logic   reset_n;
    logic   out_clk2;
    logic   out_clk4;
    logic   out_clk8;

    clock_divider dut_clock_divider(
        .clk      (clk      ),
        .reset_n  (reset_n  ),
        .out_clk2 (out_clk2 ),
        .out_clk4 (out_clk4 ),
        .out_clk8 (out_clk8 )
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        @(posedge clk)
            reset_n <= 1'b0;
        @(posedge clk)
            reset_n <= 1'b1;

        repeat(25) begin
            @(posedge clk);
            $display("| Time: %3d | Reset_n: %b | Clk: %b | Clk_2: %b | Clk_4: %b | Clk_8: %b |",
                        $time, reset_n, clk, out_clk2, out_clk4, out_clk8);
        end
        $finish;
    end

    initial begin
        $dumpfile("day10/day10.vcd");
        $dumpvars(0,tb_clock_divider);
    end


endmodule
