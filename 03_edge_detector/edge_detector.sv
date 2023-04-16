`timescale 1ns/100ps

module edgeDetector (
    input   logic clk,
    input   logic rst_n,
    input   logic in_edge,
    output  logic out_posedge,
    output  logic out_negedge
);

    logic temp_edge;

    always_ff @(posedge clk) begin : edgeDetector
        if (rst_n)
            temp_edge <= 1'b0;
        else
            temp_edge <= in_edge;
    end

    assign out_posedge = in_edge & ~temp_edge;
    assign out_negedge = ~in_edge & temp_edge;

endmodule
