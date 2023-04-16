`timescale 1ns/100ps

module gray_2_bin_encoder #(parameter DATA_WIDTH = 4) (
    input   logic [DATA_WIDTH-1:0] in_gray, 
    output  logic [DATA_WIDTH-1:0] out_bin
);

    assign out_bin[DATA_WIDTH-1] = in_gray[DATA_WIDTH-1];
    assign out_bin[DATA_WIDTH-2] = in_gray[DATA_WIDTH-1] ^ in_gray[DATA_WIDTH-2];

    genvar i;
    generate
        for (i=DATA_WIDTH-3; i>=0; i=i-1) begin 
            assign out_bin[i] = out_bin[i+1] ^ in_gray[i];
        end
    endgenerate

endmodule
