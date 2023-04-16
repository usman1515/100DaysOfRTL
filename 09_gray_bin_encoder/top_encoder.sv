`timescale 1ns/100ps

`include "09_gray_bin_encoder/bin_2_gray_encoder.sv"
`include "09_gray_bin_encoder/gray_2_bin_encoder.sv"

module top_encoder #(parameter DATA_WIDTH=4) (
    input   logic [DATA_WIDTH-1:0] in_bin,
    input   logic [DATA_WIDTH-1:0] in_gray,
    output  logic [DATA_WIDTH-1:0] out_gray,
    output  logic [DATA_WIDTH-1:0] out_bin
);

    bin_2_gray_encoder #(.DATA_WIDTH(DATA_WIDTH)) dut_bin_2_gray_encoder(
        .in_bin   (in_bin   ),
        .out_gray (out_gray )
    );

    gray_2_bin_encoder #(.DATA_WIDTH(DATA_WIDTH)) dut_gray_2_bin_encoder(
        .in_gray (in_gray ),
        .out_bin (out_bin )
    );

endmodule
