`timescale 1ns/100ps

module mux_2x1 #(parameter DATA_WIDTH=8) (
    input   logic [DATA_WIDTH-1:0]  i_dataA,
    input   logic [DATA_WIDTH-1:0]  i_dataB,
    input   logic                   i_sel,
    output  logic [DATA_WIDTH-1:0]  o_data
);

    // approach 1
    // assign o_data = (i_dataA & ~i_sel) | (i_dataB & i_sel);

    // approach 2
    // always_comb begin : rtl
    //     o_data = (i_sel)? i_dataA : i_dataB;
    // end

    // approach 3
    always_comb begin
        case (i_sel)
            1'd0: o_data = i_dataA;
            1'd1: o_data = i_dataB;
            default: o_data = 'd0;
        endcase
    end

endmodule

