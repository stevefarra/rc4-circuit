`timescale 1 ps / 1 ps

module ksa_tb();
    logic       clk;
    logic       rst;
    logic       start;

    // task1 ports
    logic [7:0] task1_addr;
    logic [7:0] task1_data;
    logic       task1_wr_en;
    logic       task1_on;
    logic       task1_fin;

    // task2 ports
    logic [7:0] task2a_addr;
    logic [7:0] task2a_data;
    logic       task2a_wr_en;
    logic       task2a_on;
    logic       task2a_fin;

    // s_memory ports
    logic [7:0] address;
    logic [7:0] data;
    logic       wr_en;
    logic [7:0] mem_out;

    // testbench control
    logic read_ram;
    int i;

    task1 task1_inst(
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .address    (task1_addr),
        .data       (task1_data),
        .wr_en      (task1_wr_en),
        .task_on    (task1_on),
        .fin_strobe (task1_fin)
    );

    task2a task2a_inst(
        .clk        (clk),
        .rst        (rst),
        .start      (task1_fin),
        .secret_key (24'h000249),
        .mem_out    (task2a_data),

        .wr_en      (task2a_wr_en),
        .fsm_on     (task2a_on),
        .fin_strobe (task2a_fin),
        .mem_in     (mem_out),
        .address    (task2a_addr)
    );

    assign address = read_ram ? i : (task1_on ? task1_addr : task2a_addr);
    assign    data = task1_on ? task1_data : task2a_data;
    assign   wr_en = task1_wr_en | task2a_wr_en;

    s_memory s_memory_inst(
        .address (address),
        .clock   (clk),
        .data    (data),
        .wren    (wr_en),
        .q       (mem_out)
    );

    always begin
        clk = 1'b0; #2;
        clk = 1'b1; #2;
    end

    initial begin
        // Task 1: Initialize RAM
                             read_ram = 1'b0;
                                  rst = 1'b1;
        repeat(4) @(negedge clk); rst = 1'b0;

        @(negedge clk); start = 1'b1;
        @(negedge clk); start = 1'b0;

        // Print out the contents of RAM
        @(negedge task2a_fin);
        @(negedge clk);
        read_ram = 1'b1;
        $display("Contents of RAM:");
        for (i = 0; i < 256; i++) begin
            @(negedge clk);
            $write("%d ", mem_out);
        end
    end
endmodule