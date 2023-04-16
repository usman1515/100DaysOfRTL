`timescale 1ns/100ps

module tb_dFlipFlop ();

    localparam DATA_WIDTH = 8;
    localparam T=5;

    logic clk;
    logic rst_n;
    logic [DATA_WIDTH-1:0] in_data;
    logic [DATA_WIDTH-1:0] out_norst;
    logic [DATA_WIDTH-1:0] out_syncrst;
    logic [DATA_WIDTH-1:0] out_asyncrst;

    dFlipFlop #(.DATA_WIDTH (DATA_WIDTH)) dut_dFlipFlop(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_data      (in_data      ),
        .out_norst    (out_norst    ),
        .out_syncrst  (out_syncrst  ),
        .out_asyncrst (out_asyncrst )
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
                        $time, rst_n, in_data, out_norst, out_syncrst, out_asyncrst);
        end
        $finish;
    end

    initial begin
        $dumpfile("02_dff/02_dff.vcd");
        $dumpvars(0,tb_dFlipFlop);
    end

endmodule
