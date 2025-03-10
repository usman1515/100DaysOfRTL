`timescale 1ns/100ps

module edge_detector (
    input   logic clk,
    input   logic rst_n,
    input   logic i_edge,
    output  logic o_posedge,
    output  logic o_negedge
);

    logic temp_edge;

    always_ff @(posedge clk) begin : edgeDetector
        if (rst_n)
            temp_edge <= 1'b0;
        else
            temp_edge <= i_edge;
    end

    assign o_posedge = i_edge & ~temp_edge;
    assign o_negedge = ~i_edge & temp_edge;

endmodule

