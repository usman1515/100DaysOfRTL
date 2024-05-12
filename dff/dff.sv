`timescale 1ns/100ps

module dff #(parameter DATA_WIDTH=1) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [DATA_WIDTH-1:0]  in_data,
    output  logic [DATA_WIDTH-1:0]  out_no_rst,
    output  logic [DATA_WIDTH-1:0]  out_sync_rst,
    output  logic [DATA_WIDTH-1:0]  out_async_rst
);

    always_ff @(posedge clk) begin : noReset
        out_no_rst <= in_data;
    end

    always_ff @(posedge clk) begin : synchronousReset
        if (rst_n)
            out_sync_rst <= 'd0;
        else
            out_sync_rst <= in_data;
        // out_sync_rst <= (rst_n)? 'd0 : in_data;
    end

    always_ff @(posedge clk or posedge rst_n) begin : asynchronousReset
        if (rst_n)
            out_async_rst <= 'd0;
        else
            out_async_rst <= in_data;
        // out_async_rst <= (rst_n)? 'd0 : in_data;
    end

endmodule