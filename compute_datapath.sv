module compute_datapath(
    input  logic       clk,
    input  logic       rst,

    input  logic [1:0] sel_addr_s_mem,
    input  logic       sel_data_s_mem,
    input  logic       inc_i,
    input  logic       store_j,
    input  logic       store_s_i,
    input  logic       store_s_j,
    input  logic       store_f,
    input  logic       inc_k,
    input  logic       store_enc_k,

    input  logic [7:0] data_from_s_mem,
    input  logic [7:0] data_from_enc_mem,

    output logic [7:0] addr_to_s_mem,
    output logic [7:0] data_to_s_mem,
    output logic [7:0] addr_to_enc_mem,
    output logic [7:0] addr_to_dec_mem,
    output logic [7:0] data_to_dec_mem,

    output logic       k5
);

    logic [7:0] i;
    logic [7:0] j;
    logic [7:0] s_i;
    logic [7:0] s_j;
    logic [7:0] f;
    logic [5:0] k;
    logic [7:0] enc_k;

    always_ff @(posedge clk)
        if      (rst)   i <= 8'b0;
        else if (inc_i) i <= i + 1'b1;

    always_ff @(posedge clk)
        if      (rst)     j <= 8'b0;
        else if (store_j) j <= j + data_from_s_mem;

    always_ff @(posedge clk)
        if      (rst)       s_i <= 8'b0;
        else if (store_s_i) s_i <= data_from_s_mem;

    always_ff @(posedge clk)
        if      (rst)       s_j <= 8'b0;
        else if (store_s_j) s_j <= data_from_s_mem;

    always_ff @(posedge clk)
        if      (rst)     f <= 8'b0;
        else if (store_f) f <= data_from_s_mem;  

    always_ff @(posedge clk)
        if      (rst)   k <= 6'b0;
        else if (inc_k) k <= k + 1;     

    always_ff @(posedge clk)
        if      (rst)         enc_k <= 8'b0;
        else if (store_enc_k) enc_k <= data_from_enc_mem; 

    always_comb
        case (sel_addr_s_mem)
              2'b00: addr_to_s_mem = i;
              2'b01: addr_to_s_mem = j;
              2'b10: addr_to_s_mem = s_i + s_j;
            default: addr_to_s_mem = i;
        endcase

    assign data_to_s_mem = sel_data_s_mem ? s_j : s_i;

    assign addr_to_enc_mem = k;

    assign addr_to_dec_mem = k;
    assign data_to_dec_mem = f ^ enc_k;

    assign k5 = k[5];
endmodule
