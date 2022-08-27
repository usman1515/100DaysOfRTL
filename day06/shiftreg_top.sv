`timescale 1ns/100ps

`include "day06/shiftreg_pipo.sv"
`include "day06/shiftreg_piso.sv"
`include "day06/shiftreg_sipo.sv"
`include "day06/shiftreg_siso.sv"

module shiftreg_top #(parameter ADDR_WIDTH=4) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic                   in_datasiso,
    input   logic                   in_datasipo,
    input   logic [ADDR_WIDTH-1:0]  in_datapiso,
    input   logic [ADDR_WIDTH-1:0]  in_datapipo,
    output  logic                   out_datasiso,
    output  logic [ADDR_WIDTH-1:0]  out_datasipo,
    output  logic                   out_datapiso,
    output  logic [ADDR_WIDTH-1:0]  out_datapipo
);

    shiftreg_siso dut_shiftreg_siso(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_datasiso  (in_datasiso  ),
        .out_datasiso (out_datasiso )
    );
    shiftreg_sipo #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_sipo(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_datasipo  (in_datasipo  ),
        .out_datasipo (out_datasipo )
    );
    shiftreg_piso #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_piso(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_datapiso  (in_datapiso  ),
        .out_datapiso (out_datapiso )
    );
    shiftreg_pipo #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_pipo(
        .clk          (clk          ),
        .rst_n        (rst_n        ),
        .in_datapipo  (in_datapipo  ),
        .out_datapipo (out_datapipo )
    );

endmodule