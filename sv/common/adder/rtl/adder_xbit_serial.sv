/*
 * @Author      : myyerrol
 * @Date        : 2024-06-24 01:15:01
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-28 14:46:21
 * @FilePath    : /memdsl-cpu/meteor/ip/sv/common/adder/rtl/adder_xbit_serial.sv
 * @Description : xbit serial carry adder
 *
 *  Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "adder_1bit_full.sv"

/**
 * @description: xbit serial carry adder
 * @param i_num_a {logic} Number a
 * @param i_num_b {logic} Number b
 * @param i_cry   {logic} Carry from lowest bit
 * @param o_res   {logic} Result
 * @param o_cry   {logic} Carry to highest bit
 */
module adder_xbit_serial #(
    parameter DATA_WIDTH = 8
) (
    input  logic [DATA_WIDTH - 1] i_num_a,
    input  logic [DATA_WIDTH - 1] i_num_b,
    input  logic                  i_cry,
    output logic [DATA_WIDTH - 1] o_res,
    output logic                  o_cry
);

    logic [DATA_WIDTH - 1 : 0] w_res;
    logic [DATA_WIDTH - 1 : 0] w_cry;

    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH; i = i + 1)
        begin: adder_xbit_serial
            adder_1bit_full adder_1bit_full_inst(
                .i_num_a(i_num_a[i]),
                .i_num_b(i_num_b[i]),
                .i_cry((i == 0) ? i_cry : w_cry[i - 1]),
                .o_res(w_res[i]),
                .o_cry(w_cry[i])
            );
        end
    endgenerate

    assign o_res = w_res;
    assign o_cry = w_cry[DATA_WIDTH - 1];

endmodule