module ksa(
    input  logic       CLOCK_50,
    input  logic [3:0] KEY,
    input  logic [9:0] SW,
    output logic [9:0] LEDR,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    logic clk;
    logic reset_n;
    logic [6:0] ssOut;
    logic [3:0] nIn;

    assign clk = CLOCK_50;
    assign reset_n = KEY[3];

    SevenSegmentDisplayDecoder mod(
        .nIn(nIn),
        .ssOut(ssOut)
    );

endmodule