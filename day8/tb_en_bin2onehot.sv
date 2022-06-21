`timescale 1ns/100ps

module tb_bin2OneHotEncoder();

    localparam BIN_WIDTH=4;
    localparam T=5;

    logic [BIN_WIDTH-1:0]       in_bin;
    logic [(2**BIN_WIDTH)-1:0]  out_onehot;

    bin2OneHotEncoder #(.BIN_WIDTH(BIN_WIDTH)) dut_bin2OneHotEncoder(
        .in_bin     (in_bin     ),
        .out_onehot (out_onehot )
    );

    initial begin
        repeat(10) begin
            in_bin = $urandom_range('h0,'hffff);
            #T;
            $display("| Time: %3d | In_Bin: %d | OutOneHot: %b |",
                        $time, in_bin, out_onehot);
        end
        $finish;
    end

    initial begin
        $dumpfile("day8/day8.vcd");
        $dumpvars(0,tb_bin2OneHotEncoder);
    end

endmodule