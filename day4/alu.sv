`timescale 1ns/100ps

module alu (
    input   logic [7:0] in_a,
    input   logic [7:0] in_b,
    input   logic [3:0] in_mode,
    output  logic [7:0] out_alu,
    output  logic       cout
);

    logic [7:0] alu_result;
    logic [8:0] tmp;

    localparam MODE0    = 4'd0;     // add
    localparam MODE1    = 4'd1;     // subtract
    localparam MODE2    = 4'd2;     // multiply
    localparam MODE3    = 4'd3;     // divide
    localparam MODE4    = 4'd4;     // left shift logical
    localparam MODE5    = 4'd5;     // right shift logical
    localparam MODE6    = 4'd6;     // rotate left
    localparam MODE7    = 4'd7;     // rotate right
    localparam MODE8    = 4'd8;     // logical and
    localparam MODE9    = 4'd9;     // logical or
    localparam MODE10   = 4'd10;    // logical xor
    localparam MODE11   = 4'd11;    // logical nand
    localparam MODE12   = 4'd12;    // logical nor
    localparam MODE13   = 4'd13;    // logical xnor
    localparam MODE14   = 4'd14;    // greater comparison
    localparam MODE15   = 4'd15;    // equal comparison

    always@(*) begin : alumodes
        case(in_mode)
            4'd0    : alu_result = in_a + in_b;
            4'd1    : alu_result = in_a - in_b;
            4'd2    : alu_result = in_a * in_b;
            4'd3    : alu_result = in_a / in_b;
            4'd4    : alu_result = in_a << 1;
            4'd5    : alu_result = in_a >> 1;
            4'd6    : alu_result = {in_a[6:0], in_a[7]};
            4'd7    : alu_result = {in_a[0], in_a[7:1]};
            4'd8    : alu_result = in_a & in_b;
            4'd9    : alu_result = in_a | in_b;
            4'd10   : alu_result = in_a ^ in_b;
            4'd11   : alu_result = ~(in_a & in_b);
            4'd12   : alu_result = ~(in_a | in_b);
            4'd13   : alu_result = ~(in_a ^ in_b);
            4'd14   : alu_result = (in_a > in_b)? 8'd1 : 8'd0;
            4'd15   : alu_result = (in_a == in_b)? 8'd1 : 8'd0;
            default: alu_result  = in_a + in_b;
        endcase
    end

    assign out_alu = alu_result;
    assign tmp = {1'b0,in_a} + {1'b0,in_b};
    assign cout = tmp[8];

endmodule
