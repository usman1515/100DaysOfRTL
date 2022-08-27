`timescale 1ns/100ps

module tb_counter();

    localparam ADDR_WIDTH=4;
    localparam T=5;

    logic                   clk;
    logic                   rst_n;
    logic [ADDR_WIDTH-1:0]  out_cnt;
    logic [ADDR_WIDTH-1:0]  out_oddcnt;
    logic [ADDR_WIDTH-1:0]  out_evencnt;

    counter #(.ADDR_WIDTH(ADDR_WIDTH)) dut_counter(
        .clk         (clk         ),
        .rst_n       (rst_n       ),
        .out_cnt     (out_cnt     ),
        .out_oddcnt  (out_oddcnt  ),
        .out_evencnt (out_evencnt )
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        @(posedge clk)
            rst_n <= 1'b1;
        @(posedge clk)
            rst_n <= 1'b0;

        repeat(10) begin
            @(posedge clk);
            $display("| Time: %3d | Reset_n: %d | OutCounter: %3d | OutCounterOdd: %3d | OutCounterEven: %3d |",
                        $time, rst_n, out_cnt, out_oddcnt, out_evencnt);
        end
        $finish;
    end

    initial begin
        $dumpfile("day05/day05.vcd");
        $dumpvars(0,tb_counter);
    end

endmodule
