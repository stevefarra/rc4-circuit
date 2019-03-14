module task2a(
    input  logic        clk,
    input  logic        rst,
    input  logic        start,

    input  logic [23:0] secret_key,
    input  logic  [7:0] mem_out,

    output logic        wr_en,
    output logic        fsm_on,
    output logic        fin_strobe,

    output logic  [7:0] mem_in,
    output logic  [7:0] address
);

    logic       inc_i;
    logic       sel_addr_j;
    logic       sel_data_j;
    logic       store_data_i;
    logic       store_data_j;
    logic       store_j;
    logic [7:0] i;

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
        .fsm_on       (fsm_on),
        .fin_strobe   (fin_strobe)
    );

    shuffle_datapath shuffle_datapath_inst(
        .clk          (clk),
        .rst          (rst),
        .inc_i        (inc_i),
        .sel_addr_j   (sel_addr_j),
        .sel_data_j   (sel_data_j),
        .store_data_i (store_data_i),
        .store_data_j (store_data_j),
        .store_j      (store_j),
        .secret_key   (secret_key),
        .mem_out      (mem_out),

        .mem_in       (mem_in),
        .address      (address),
        .i            (i)
    );
endmodule