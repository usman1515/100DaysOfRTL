`timescale 1ns/100ps

module tb_lfsr();

    localparam T=5;

    logic       clk;
    logic       rst_n;
    logic [7:0] out_data;

    lfsr dut_lfsr(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .out_data (out_data )
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
            $display("| Time: %3d | Reset_n: %b | OutData: %b |",$time, rst_n, out_data);
        end
        $finish;
    end

    initial begin
        $dumpfile("07_lfsr/07_lfsr.vcd");
        $dumpvars(0,tb_lfsr);
    end

endmodule
