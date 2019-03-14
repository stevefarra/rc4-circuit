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
    input  logic  [7:0] mem_out,

    output logic  [8:0] i,

    output logic  [7:0] address,
    output logic  [7:0] mem_in
);

    logic [7:0] j;

    logic [7:0] data_i;
    logic [7:0] data_j;

    logic [7:0] secret_byte;

    assign address = sel_addr_j ?      j : i;
    assign  mem_in = sel_data_j ? data_j : data_i;

    always_ff @(posedge clk)
        if      (rst)          data_i <= 8'b0;
        else if (store_data_i) data_i <= mem_out;

    always_ff @(posedge clk)
        if      (rst)          data_j <= 8'b0;
        else if (store_data_i) data_j <= mem_out;

    always_ff @(posedge clk)
        if      (rst)   i = 9'b0;
        else if (inc_i) i = i + 1'b1;

    always_comb
        case (i % 3)
            2'b00: secret_byte <= secret_key[23:16];
            2'b01: secret_byte <= secret_key[15:8];
            2'b10: secret_byte <= secret_key[7:0];
        endcase

    always_ff @(posedge clk)
        if      (rst)     j <= 8'b0;
        else if (store_j) j <= j + mem_out + secret_byte;
endmodule
