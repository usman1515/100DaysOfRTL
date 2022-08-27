`timescale 1ns/100ps

module shiftreg_siso (
    input   logic   clk,
    input   logic   rst_n,
    input   logic   in_datasiso,
    output  logic   out_datasiso
);

    always_ff @(posedge clk) begin : SerialInSerialOut
        if (rst_n)
            out_datasiso <= 'd0;
        else
            out_datasiso <= in_datasiso;
    end
endmodule
