`timescale 1ns/100ps

module tb_mux_2x1;

    localparam DATA_WIDTH = 8;
    logic [DATA_WIDTH-1:0]  i_dataA;
    logic [DATA_WIDTH-1:0]  i_dataB;
    logic                   i_sel;
    logic [DATA_WIDTH-1:0]  o_data;

    mux_2x1 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut_mux (
        .i_dataA(i_dataA),
        .i_dataB(i_dataB),
        .i_sel(i_sel),
        .o_data(o_data)
    );

    initial begin
        repeat(10) begin
            i_dataA = $urandom_range('h0,'hff);
            i_dataB = $urandom_range('h0,'hff);
            i_sel   = $urandom_range(0, 1);
            #1;
            $display("| Time: %2d | A: %h | B: %h | i_sel: %1d | o_data: %h |",
                $time, i_dataA, i_dataB, i_sel, o_data);
        end

        $finish;
    end

    initial begin
        $dumpfile("tb_mux.vcd");
        $dumpvars(0, tb_mux);
    end

endmodule
