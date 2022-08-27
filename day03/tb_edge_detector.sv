`timescale 1ns/100ps

module tb_edgeDetector();

    localparam T=5;
    logic clk;
    logic rst_n;
    logic in_edge;
    logic out_posedge;
    logic out_negedge;

    edgeDetector dut_edge_detector(
        .clk         (clk         ),
        .rst_n       (rst_n       ),
        .in_edge     (in_edge     ),
        .out_posedge (out_posedge ),
        .out_negedge (out_negedge )
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        for (int i=0; i<20; i++) begin
            rst_n = $random%2;
            in_edge = $random%2;
            @(posedge clk);
            $display("| Time: %3d | Reset_n: %h | InEdge: %h | OutPosEdge: %h | OutNegEdge: %h |",
                        $time, rst_n, in_edge, out_posedge, out_negedge);
        end
        $finish;
    end

    initial begin
        $dumpfile("day03/day03.vcd");
        $dumpvars(0,tb_edgeDetector);
    end

endmodule
