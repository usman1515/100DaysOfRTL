`timescale 1ns/100ps

module tb_self_reloading_counter();

    localparam DATA_WIDTH=4;
    localparam T=2;
    int min_num=0;
    int max_num=2**DATA_WIDTH;
    int cycles=0;

    logic                   clk;
    logic                   reset_n;
    logic                   in_loaden;
    logic [DATA_WIDTH-1:0]  in_load_val;
    logic [DATA_WIDTH-1:0]  out_cnt;

    self_reloading_counter #(.DATA_WIDTH (DATA_WIDTH)) dut_self_reloading_counter(
        .clk         (clk         ),
        .reset_n     (reset_n     ),
        .in_loaden   (in_loaden   ),
        .in_load_val (in_load_val ),
        .out_cnt     (out_cnt     )
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        reset_n <= 1'b1;
        @(posedge clk);
        $display("Time: %3d | Reset_n: %d | InLoadEn: %d | InLoadValue: %3d | Cycles: %3d | OutCounter: %3d",
                $time, reset_n, in_loaden, in_load_val, cycles, out_cnt);

        repeat(3) begin
            in_loaden <= 1'b1;
            in_load_val <= $urandom_range(min_num, max_num);
            $display("Time: %3d | Reset_n: %d | InLoadEn: %d | InLoadValue: %3d | Cycles: %3d | OutCounter: %3d \n",
                $time, reset_n, in_loaden, in_load_val, cycles, out_cnt);
            @(posedge clk);

            repeat(16) begin
                in_loaden <= 1'd0;
                $display("Time: %3d | Reset_n: %d | InLoadEn: %d | InLoadValue: %3d | Cycles: %3d | OutCounter: %3d",
                    $time, reset_n, in_loaden, in_load_val, cycles, out_cnt);
                @(posedge clk);
            end
        end

        $finish;
    end

    initial begin
        $dumpfile("11_self_reloading_counter/11_self_reloading_counter.vcd");
        $dumpvars(0, tb_self_reloading_counter);
    end

endmodule
