`timescale 1ns/100ps

module counter #(parameter ADDR_WIDTH=2) (
    input   logic                   clk,
    input   logic                   rst_n,
    output  logic [ADDR_WIDTH-1:0]  out_cnt,
    output  logic [ADDR_WIDTH-1:0]  out_oddcnt,
    output  logic [ADDR_WIDTH-1:0]  out_evencnt
);

    logic [ADDR_WIDTH-1:0] count;
    logic [ADDR_WIDTH-1:0] count_odd;
    logic [ADDR_WIDTH-1:0] count_even;

    always_ff @(posedge clk) begin
        if (rst_n) begin
            count       <= 'd0;
            count_odd   <= 'd1;
            count_even  <= 'd0;
        end
        else begin
            count       <= count + 'd1;
            count_odd   <= count_odd + 'd2;
            count_even  <= count_even + 'd2;
        end
    end

    assign out_cnt = count;
    assign out_oddcnt = count_odd;
    assign out_evencnt = count_even;

endmodule