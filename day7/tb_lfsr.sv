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
        end
        $finish;
    end

    initial begin
        $dumpfile("day7/day7.vcd");
        $dumpvars(0,tb_lfsr);
    end

endmodule
