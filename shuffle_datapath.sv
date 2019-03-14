module shuffle_datapath(
    input  logic        clk,
    input  logic        rst,
    input  logic        inc_i,
    input  logic        sel_addr_j,
    input  logic        sel_data_j,
    input  logic        store_data_i,
    input  logic        store_data_j,
    input  logic        store_j,

    input  logic [23:0] secret_key,
    input  logic  [7:0] data_from_mem,

    output logic  [8:0] i,

    output logic  [7:0] address,
    output logic  [7:0] data_to_mem
);

    logic [7:0] j;

    logic [7:0] data_i;
    logic [7:0] data_j;

    logic [7:0] secret_byte;

    assign      address = sel_addr_j ?      j : i[7:0];
    assign  data_to_mem = sel_data_j ? data_j : data_i;

    always_ff @(posedge clk)
        if      (rst)          data_i <= 8'b0;
        else if (store_data_i) data_i <= data_from_mem;

    always_ff @(posedge clk)
        if      (rst)          data_j <= 8'b0;
        else if (store_data_j) data_j <= data_from_mem;

    always_ff @(posedge clk)
        if      (rst)   i = 9'b0;
        else if (inc_i) i = i + 1'b1;

    always_comb
        case (i % 3)
              2'b00: secret_byte <= secret_key[23:16];
              2'b01: secret_byte <= secret_key[15:8];
              2'b10: secret_byte <= secret_key[7:0];
            default: secret_byte <= secret_key[7:0];
        endcase

    always_ff @(posedge clk)
        if      (rst)     j <= 8'b0;
        else if (store_j) j <= j + data_from_mem + secret_byte;
endmodule
