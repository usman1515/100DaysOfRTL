`timescale 1ns/100ps

module tb_mux2x1();

    localparam DATA_WIDTH = 8;
    logic [DATA_WIDTH-1:0]  in_a;
    logic [DATA_WIDTH-1:0]  in_b;
    logic                   sel;
    logic [DATA_WIDTH-1:0]  out;

    mux2x1 #(.DATA_WIDTH(DATA_WIDTH)) dut_mux2x1(
        .in_a (in_a ),
        .in_b (in_b ),
        .sel  (sel  ),
        .out  (out  )
    );

    initial begin
        for (int i=0; i<10; i=i+1) begin
            in_a    = $urandom_range('h0,'hff);
            in_b    = $urandom_range('h0,'hff);
            sel     = i%2;
            #1;
            $display("| Time: %2d | Input_A: %h | Input_B: %h | Sel: %1d | Output: %h |",$time,in_a,in_b,sel,out);
        end
        $finish;
    end

    initial begin
        $dumpfile("day01/day01.vcd");
        $dumpvars(0,tb_mux2x1);
    end

endmodule