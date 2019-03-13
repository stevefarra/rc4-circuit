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

    // s_memory ports
    logic [7:0] address;
    logic [7:0] data;
    logic       wr_en;
    logic [7:0] mem_out;

    // testbench control
    logic read_ram;
    int i;

    assign address = read_ram ? i : task1_addr;
    assign    data = task1_data;
    assign   wr_en = task1_wr_en;

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
                             read_ram = 1'b0;
                                  rst = 1'b1;
        repeat(4) @(negedge clk); rst = 1'b0;

        @(negedge clk); start = 1'b1;
        @(negedge clk); start = 1'b0;

        @(negedge task1_fin);
        @(negedge clk);
        read_ram = 1'b1;
        $display("Contents of RAM:");
        for (i = 0; i < 256; i++) begin
            @(negedge clk);
            $write("%d ", mem_out);
        end
    end
endmodule