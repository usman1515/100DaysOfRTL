`timescale 1ns/100ps

module tb_gray_bin_encoders();

    localparam VECTOR_WIDTH=4;
    localparam T=5;

    logic [VECTOR_WIDTH-1:0] in_bin;
    logic [VECTOR_WIDTH-1:0] out_bin;
    logic [VECTOR_WIDTH-1:0] out_gray;

    top_encoder #(.DATA_WIDTH (VECTOR_WIDTH)) dut_top_encoder(
        .in_bin   (in_bin   ),
        .in_gray  (out_gray ),
        .out_gray (out_gray ),
        .out_bin  (out_bin  )
    );

    initial begin
        for (int i=0; i<(2**VECTOR_WIDTH); i=i+1) begin
            in_bin = i;
            #T;
            $display("| Time: %4d | In_Bin: %b | Out_Gray: %b | In_Gray: %b | Out_Bin: %b |",
                        $time, in_bin, out_gray, out_gray, out_bin);
        end
    end

    initial begin
        $dumpfile("09_gray_bin_encoder/09_gray_bin_encoder.vcd");
        $dumpvars(0,tb_gray_bin_encoders);
    end

endmodule