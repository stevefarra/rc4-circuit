module task2a(
    input  logic        clk,
    input  logic        rst,
    input  logic        start,

    input  logic  [7:0] data_in,
    input  logic [23:0] secret_key,

    output logic  [7:0] address,
    output logic  [7:0] data_out,
    output logic        wr_en,
    output logic        task_on,
    output logic        fin_strobe
);

    logic       inc_i;
    logic       sel_addr_j;
    logic       sel_data_j;
    logic       store_data_i;
    logic       store_data_j;
    logic       store_j;
    logic [8:0] i;

    shuffle_fsm shuffle_fsm_inst(
        .clk          (clk),
        .rst          (rst),
        .start        (start),

        .i            (i),
        .inc_i        (inc_i),
        .sel_addr_j   (sel_addr_j),
        .sel_data_j   (sel_data_j),
        .wr_en        (wr_en),
        .store_data_i (store_data_i),
        .store_data_j (store_data_j),
        .store_j      (store_j),
        .fsm_on       (task_on),
        .fin_strobe   (fin_strobe)
    );

    shuffle_datapath shuffle_datapath_inst(
        .clk           (clk),
        .rst           (rst),
        .inc_i         (inc_i),
        .sel_addr_j    (sel_addr_j),
        .sel_data_j    (sel_data_j),
        .store_data_i  (store_data_i),
        .store_data_j  (store_data_j),
        .store_j       (store_j),
        .secret_key    (secret_key),
        .data_from_mem (data_in),

        .data_to_mem   (data_out),
        .address       (address),
        .i             (i)
    );
endmodule