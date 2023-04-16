`timescale 1ns/100ps

module shiftreg_piso #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [ADDR_WIDTH-1:0]  in_datapiso,
    output  logic                   out_datapiso
);

    logic [ADDR_WIDTH-1:0] temp;

    always_ff @(posedge clk) begin : ParallelInSerialOut
        if (rst_n) begin
            out_datapiso <= 'd0;
            temp <= in_datapiso;
        end
        else begin
            out_datapiso <= temp[0];
            temp <= temp >> 1'b1;
        end
    end
endmodule
