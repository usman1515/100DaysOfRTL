`timescale 1ns/100ps

module shiftreg_siso (
    input   logic   clk,
    input   logic   rst_n,
    input   logic   in_data,
    output  logic   out_data
);

    always_ff @(posedge clk) begin : SerialInSerialOut
        if (rst_n)
            out_data <= 'd0;
        else
            out_data <= in_data;
    end
endmodule


module shiftreg_sipo #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic                   in_data,
    output  logic [ADDR_WIDTH-1:0]  out_data
);

    logic [ADDR_WIDTH-1:0] temp;

    always_ff @(posedge clk) begin : SerialInParallelOut
        if (rst_n)
            out_data <= 'd0;
        else begin
            temp <= temp << 1'b1;
            temp[0] <= in_data;
            out_data <= temp;
        end
    end
    // assign out_data = temp;
endmodule


module shiftreg_piso #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [ADDR_WIDTH-1:0]  in_data,
    output  logic                   out_data
);

    logic [ADDR_WIDTH-1:0] temp;

    always_ff @(posedge clk) begin : ParallelInSerialOut
        if (rst_n) begin
            out_data <= 'd0;
            temp <= in_data;
        end
        else begin
            out_data <= temp[0];
            temp <= temp >> 1'b1;
        end
    end
endmodule


module shiftreg_pipo #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic [ADDR_WIDTH-1:0]  in_data,
    output  logic [ADDR_WIDTH-1:0]  out_data
);

    always_ff @(posedge clk) begin : ParallelInParallelOut
        if (rst_n)
            out_data <= 'd0;
        else
            out_data <= in_data;
    end
endmodule



module shiftreg_top #(parameter ADDR_WIDTH=8) (
    input   logic                   clk,
    input   logic                   rst_n,
    input   logic                   in_siso,
    input   logic                   in_sipo,
    input   logic [ADDR_WIDTH-1:0]  in_piso,
    input   logic [ADDR_WIDTH-1:0]  in_pipo,
    output  logic                   out_siso,
    output  logic [ADDR_WIDTH-1:0]  out_sipo,
    output  logic                   out_piso,
    output  logic [ADDR_WIDTH-1:0]  out_pipo
);

    shiftreg_siso dut_shiftreg_siso(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .in_data  (in_siso  ),
        .out_data (out_siso )
    );
    shiftreg_sipo #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_sipo(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .in_data  (in_sipo  ),
        .out_data (out_sipo )
    );
    shiftreg_piso #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_piso(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .in_data  (in_piso  ),
        .out_data (out_piso )
    );
    shiftreg_pipo #(.ADDR_WIDTH (ADDR_WIDTH)) dut_shiftreg_pipo(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .in_data  (in_pipo  ),
        .out_data (out_pipo )
    );

endmodule