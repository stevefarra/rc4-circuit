module counter_en #(parameter n = 8) (
    input  logic         clk,
    input  logic         rst,
    input  logic         inc_en,
    output logic [n-1:0] count
);

    always_ff @(posedge clk)
        if      (rst)    count = 0;
        else if (inc_en) count = count + 1'b1;
endmodule