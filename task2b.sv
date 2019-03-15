module task2b(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,

    input  logic [7:0] data_from_s_mem,
    input  logic [7:0] data_from_enc_mem,

    output logic       wr_en,
    output logic       wr_en_dec,
    output logic       task_on,
    output logic       fin_strobe,

    output logic [7:0] addr_to_s_mem,
    output logic [7:0] data_to_s_mem,
    output logic [7:0] addr_to_enc_mem,
    output logic [7:0] addr_to_dec_mem,
    output logic [7:0] data_to_dec_mem
);

    logic [1:0] sel_addr_s_mem;
    logic       sel_data_s_mem;
    logic       inc_i;
    logic       store_j;
    logic       store_s_i;
    logic       store_s_j;
    logic       store_f;
    logic       inc_k;
    logic       store_enc_k;
    logic       k5;

    compute_fsm compute_fsm_inst(
        .clk           (clk),
        .rst           (rst),
        .start         (start),
        .stop          (k5),

        .sel_addr_s_mem (sel_addr_s_mem),
        .sel_data_s_mem (sel_data_s_mem),
        .wr_en          (wr_en),
        .wr_en_dec      (wr_en_dec),
        .inc_i          (inc_i),
        .store_j        (store_j),
        .store_s_i      (store_s_i),
        .store_s_j      (store_s_j),
        .store_f        (store_f),
        .inc_k          (inc_k),
        .store_enc_k    (store_enc_k),
        .fsm_on         (task_on),
        .fin_strobe     (fin_strobe)
    );

    compute_datapath compute_datapath_inst(
        .clk              (clk),
        .rst              (rst),
        .sel_addr_s_mem   (sel_addr_s_mem),
        .sel_data_s_mem   (sel_data_s_mem),
        .inc_i            (inc_i),
        .store_j          (store_j),
        .store_s_i        (store_s_i),
        .store_s_j        (store_s_j),
        .store_f          (store_f),
        .inc_k            (inc_k),
        .store_enc_k      (store_enc_k),
        .data_from_s_mem  (data_from_s_mem),
        .data_from_enc_mem(data_from_enc_mem),

        .addr_to_s_mem    (addr_to_s_mem),
        .data_to_s_mem    (data_to_s_mem),
        .addr_to_enc_mem  (addr_to_enc_mem),
        .addr_to_dec_mem  (addr_to_dec_mem),
        .data_to_dec_mem  (data_to_dec_mem),
        .k5               (k5)
    );
endmodule
