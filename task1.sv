module task1(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,

    output logic [7:0] address,
    output logic [7:0] data,
    output logic       wr_en,
    output logic       task_on,
    output logic       fin_strobe
);
    logic [8:0] addr_and_data;
    logic       wr_and_inc;

    init_ram_fsm init_ram_fsm_inst(
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .count      (addr_and_data),
        .wr_and_inc (wr_and_inc),
        .fin_strobe (fin_strobe)
    );

    counter_en #(9) addr_and_data_reg(
        .clk    (clk),
        .rst    (rst),
        .inc_en (wr_and_inc),
        .count  (addr_and_data)
    );

    assign address = addr_and_data[7:0];
    assign    data = addr_and_data[7:0];
    assign   wr_en = wr_and_inc;
    assign task_on = wr_and_inc;
endmodule
