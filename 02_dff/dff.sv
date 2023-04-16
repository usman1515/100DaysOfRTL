`timescale 1ns/100ps

module dFlipFlop #(parameter DATA_WIDTH=1) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [DATA_WIDTH-1:0]  in_data,
    output  logic [DATA_WIDTH-1:0]  out_norst,
    output  logic [DATA_WIDTH-1:0]  out_syncrst,
    output  logic [DATA_WIDTH-1:0]  out_asyncrst
);

    always_ff @(posedge clk) begin : noReset
        out_norst <= in_data;
    end

    always_ff @(posedge clk) begin : synchronousReset
        if (rst_n)
            out_syncrst <= 'd0;
        else
            out_syncrst <= in_data;
        // out_syncrst <= (rst_n)? 'd0 : in_data; 
    end

    always_ff @(posedge clk or posedge rst_n) begin : asynchronousReset
        if (rst_n)
            out_asyncrst <= 'd0;
        else
            out_asyncrst <= in_data;
        // out_asyncrst <= (rst_n)? 'd0 : in_data;
    end

endmodule