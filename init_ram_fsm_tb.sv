`timescale 1 ps / 1 ps

module init_ram_fsm_tb();
    logic       sim_clk;
    logic       sim_rst;
    logic       sim_start;
    logic [7:0] sim_count;
    logic       sim_wr_and_inc;
    logic       sim_fin_strobe;
    logic [7:0] sim_mem_out;

    init_ram_fsm init_ram_fsm_inst(
        .clk        (sim_clk),
        .rst        (sim_rst),
        .start      (sim_start),
        .count      (sim_count),
        .wr_and_inc (sim_wr_and_inc),
        .fin_strobe (sim_fin_strobe)
    );

    counter_en #(8) addr_and_data_reg(
        .clk    (sim_clk),
        .rst    (sim_rst),
        .inc_en (sim_wr_and_inc),
        .count  (sim_count)
    );

    s_memory s_memory_inst(
        .address (sim_count),
        .clock   (sim_clk),
        .data    (sim_count),
        .wren    (sim_wr_and_inc),
        .q       (sim_mem_out)
    );

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    initial begin
                            sim_rst = 1'b1;
        @(negedge sim_clk); sim_rst = 1'b0;

        @(negedge sim_clk); sim_start = 1'b1;
        @(negedge sim_clk); sim_start = 1'b0;
    end
endmodule