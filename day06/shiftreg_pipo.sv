`timescale 1ns/100ps

module shiftreg_pipo #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [ADDR_WIDTH-1:0]  in_datapipo,
    output  logic [ADDR_WIDTH-1:0]  out_datapipo
);

    always_ff @(posedge clk) begin : ParallelInParallelOut
        if (rst_n)
            out_datapipo <= 'd0;
        else
            out_datapipo <= in_datapipo;
    end
endmodule