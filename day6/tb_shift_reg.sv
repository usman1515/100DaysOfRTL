`timescale 1ns/100ps

module tb_shiftreg();

    localparam ADDR_WIDTH=4;
    localparam T=5;

    logic                   clk;
    logic                   rst_n;
    logic                   in_siso;
    logic                   in_sipo;
    logic [ADDR_WIDTH-1:0]  in_piso;
    logic [ADDR_WIDTH-1:0]  in_pipo;
    logic                   out_siso;
    logic [ADDR_WIDTH-1:0]  out_sipo;
    logic                   out_piso;
    logic [ADDR_WIDTH-1:0]  out_pipo;

    shiftreg_top dut_shiftreg_top(
        .clk      (clk      ),
        .rst_n    (rst_n    ),
        .in_siso  (in_siso  ),
        .in_sipo  (in_sipo  ),
        .in_piso  (in_piso  ),
        .in_pipo  (in_pipo  ),
        .out_siso (out_siso ),
        .out_sipo (out_sipo ),
        .out_piso (out_piso ),
        .out_pipo (out_pipo )
    );

    always begin
        #T clk=1'b0; #T clk=1'b1;
    end

    initial begin
        @(posedge clk)
            rst_n <= 1'b1;
        @(posedge clk)
            rst_n <= 1'b0;
        
        repeat(10) begin
            @(posedge clk);
            in_siso = $random%2;
            in_sipo = $random%2;
            in_piso = $random;
            in_pipo = $random;
            $display("| Time: %3d | Reset_n: %b ",$time, rst_n,
                    "| inData_SISO: %4b | outData_SISO: %4b | inData_SIPO: %4b | outData_SIPO: %4b | ",
                    in_siso, out_siso, in_sipo, out_sipo);
            $display("| Time: %3d | Reset_n: %b ",$time, rst_n,
                    "| inData_PISO: %4b | outData_PISO: %4b | inData_PIPO: %4b | outData_PIPO: %4b | \n",
                    in_piso, out_piso, in_pipo, out_pipo);
        end
        $finish;
    end

    initial begin
        $dumpfile("day6/day6.vcd");
        $dumpvars(0,tb_shiftreg);
    end

endmodule
