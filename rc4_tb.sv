`timescale 1 ps / 1 ps

module rc4_tb();
    logic       clk;
    logic       rst;
    logic       start;

    // task1 ports
    logic [7:0] task1_addr;
    logic [7:0] task1_data;
    logic       task1_wr_en;
    logic       task1_on;
    logic       task1_fin;

    // task2a ports
    logic [7:0] task2a_addr;
    logic [7:0] task2a_data;
    logic       task2a_wr_en;
    logic       task2a_on;
    logic       task2a_fin;

    // task2b ports
    logic [7:0] task2b_addr;
    logic [7:0] task2b_data;
    logic       task2b_wr_en;
    logic       task2b_on;
    logic       task2b_fin;

    // s_memory ports
    logic [7:0] address;
    logic [7:0] data;
    logic       wr_en;
    logic [7:0] s_out;

    // enc_memory ports
    logic [7:0] address_enc;
    logic [7:0] enc_out;

    // dec_memory ports
    logic [7:0] address_dec;
    logic [7:0] data_dec;
    logic       wr_en_dec;
    logic [7:0] dec_out;

    // testbench control
    logic read_mem;
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
        .data_in    (s_out),
        .secret_key (24'h000249),

        .address    (task2a_addr),
        .data_out   (task2a_data),
        .wr_en      (task2a_wr_en),
        .task_on    (task2a_on),
        .fin_strobe (task2a_fin)
    );

    task2b task2b_inst(
        .clk              (clk),
        .rst              (rst),
        .start            (task2a_fin),
        .data_from_s_mem  (s_out),
        .data_from_enc_mem(enc_out),

        .addr_to_s_mem    (task2b_addr),
        .data_to_s_mem    (task2b_data),
        .wr_en            (task2b_wr_en),
        .addr_to_enc_mem  (address_enc),
        .addr_to_dec_mem  (address_dec),
        .data_to_dec_mem  (data_dec),
        .wr_en_dec        (wr_en_dec),
        .task_on          (task2b_on),
        .fin_strobe       (task2b_fin)
    );

    always_comb begin
        if      (task1_on)  address <= task1_addr;
        else if (task2a_on) address <= task2a_addr;
        else                address <= task2b_addr;
    end

    always_comb begin
        if      (task1_on)  data <= task1_data;
        else if (task2a_on) data <= task2a_data;
        else                data <= task2b_data;
    end

    assign wr_en = task1_wr_en | task2a_wr_en | task2b_wr_en;

    s_memory s_memory_inst(
        .address (address),
        .clock   (clk),
        .data    (data),
        .wren    (wr_en),

        .q       (s_out)
    );

    enc_memory enc_memory_inst(
        .address (address_enc),
        .clock   (clk),

        .q       (enc_out)
    );

    // Debug
    logic [7:0] debug_address_dec;
    assign      debug_address_dec = read_mem ? i : address_dec;

    dec_memory dec_memory_inst(
        .address (debug_address_dec),
        .clock   (clk),
        .data    (data_dec),
        .wren    (wr_en_dec),

        .q       (dec_out)
    );

    always begin
        clk = 1'b0; #2;
        clk = 1'b1; #2;
    end

    initial begin
        // Task 1: Initialize S
        read_mem = 1'b0;

                                  rst = 1'b1;
        repeat(4) @(negedge clk); rst = 1'b0;

        @(negedge clk); start = 1'b1;
        @(negedge clk); start = 1'b0;

        // Print out the contents of Decrypted RAM:
        @(negedge task2b_fin);
        @(negedge clk);
        read_mem = 1'b1;
        $display("Contents of Decrypted RAM:");
        for (i = 0; i < 32; i++) begin
            @(negedge clk);
            $write("%h ", dec_out);
        end
    end
endmodule