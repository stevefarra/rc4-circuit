module init_ram_fsm(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    input  logic [8:0] count,
    output logic       wr_and_inc,
    output logic       fin_strobe
);

    typedef enum logic [1:0] {
          IDLE = 2'b00,
        UPDATE = 2'b01,
          DONE = 2'b10
    } statetype;
    
    statetype state;

    always_ff @(posedge clk)
        if (rst) 
            state <= IDLE;
        else
            case (state)
                IDLE: if   (start) state <= UPDATE;
                      else         state <= IDLE;

                UPDATE: if   (count[8]) state <= DONE;
                        else            state <= UPDATE;

                DONE: state <= IDLE;

                default: state <= IDLE;
            endcase

    assign wr_and_inc = state[0];
    assign fin_strobe = state[1];
endmodule
