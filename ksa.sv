module ksa(
    input  logic       CLOCK_50,
    input  logic [3:0] KEY,
    input  logic [9:0] SW,
    output logic [9:0] LEDR,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    logic clk;
    logic rst;
    logic start_task1;
    logic start_task2;
    logic start_task3;

    logic [6:0] ssOut;
    logic [3:0] nIn;

    logic [7:0] addr_and_data;
    logic       wr_and_inc;
    logic       fin_strobe;

    assign         clk = CLOCK_50;
    assign         rst = ~KEY[3];
    assign start_task1 = ~KEY[2];
    assign start_task2 = ~KEY[1];
    assign start_task3 = ~KEY[0];

    SevenSegmentDisplayDecoder mod(
        .nIn(nIn),
        .ssOut(ssOut)
    );

    init_ram_fsm init_ram_fsm_inst(
        .clk        (clk),
        .rst        (rst),
        .start      (start_task1),
        .count      (addr_and_data),
        .wr_and_inc (wr_and_inc),
        .fin_strobe (fin_strobe)
    );

    counter_en addr_and_data_reg(
        .clk    (clk),
        .rst    (rst),
        .inc_en (wr_and_inc),
        .count  (addr_and_data)
    );

    s_memory s_memory_inst(
        .address (addr_and_data),
        .clock   (clk),
        .data    (addr_and_data),
        .wren    (wr_and_inc),
        .q       ()
    );

endmodule