`timescale 1ns/100ps

module tb_dff;

    localparam DATA_WIDTH = 8;
    localparam T=5;

    logic clk;
    logic rst_n;
    logic [DATA_WIDTH-1:0] in_data;
    logic [DATA_WIDTH-1:0] out_no_rst;
    logic [DATA_WIDTH-1:0] out_sync_rst;
    logic [DATA_WIDTH-1:0] out_async_rst;

    dff #(
        .DATA_WIDTH (DATA_WIDTH)
    ) dut_dff (
        .clk(clk),
        .rst_n(rst_n),
        .in_data(in_data),
        .out_no_rst(out_no_rst),
        .out_sync_rst(out_sync_rst),
        .out_async_rst(out_async_rst)
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        for (int i=0; i<10; i++) begin
            rst_n = i%2;
            in_data = $urandom_range('h0,'hff);
            #(T*2);
            $display("| Time: %3d | Reset_n: %h | InData: %h | OutNoRstData: %h | OutSyncData: %h | OutAsyncData: %h |",
                        $time, rst_n, in_data, out_no_rst, out_sync_rst, out_async_rst);
        end
        $finish;
    end

    initial begin
        $dumpfile("tb_dff.vcd");
        $dumpvars(0, tb_dff);
    end

endmodule
