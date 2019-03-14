module shuffle_fsm(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,

    input  logic [8:0] i,
    
    output logic       inc_i,
    output logic       sel_addr_j,
    output logic       sel_data_j,
    output logic       wr_en,
    output logic       store_data_i,
    output logic       store_data_j,
    output logic       store_j,
    output logic       fsm_on,
    output logic       fin_strobe
);
    // {state_econding, 
    //  inc_i, sel_addr_j, sel_data_j, wr_en, store_data_i, store_data_j, store_j,
    //  fsm_on, fin_strobe}
    typedef enum logic [11:0] {
                  IDLE = 12'b000_0000000_00,
                 RD_SI = 12'b001_0000000_10,
          STR_SI_AND_J = 12'b010_0000101_10,
               READ_SJ = 12'b011_0100000_10,
     STR_SJ_WR_SI_TO_J = 12'b100_0101010_10,
      WR_SJ_TO_I_INC_I = 12'b101_1011000_10,
               CHECK_I = 12'b110_0000000_10,
                  DONE = 12'b111_0000000_01
    } statetype;
    
    statetype state;

    always_ff @(posedge clk)
        if (rst) 
            state <= IDLE;
        else
            case (state)
                IDLE: if   (start) state <= RD_SI;
                      else         state <= IDLE;

                RD_SI: state <= STR_SI_AND_J;

                STR_SI_AND_J: state <= READ_SJ;

                READ_SJ: state <= STR_SJ_WR_SI_TO_J;

                STR_SJ_WR_SI_TO_J: state <= WR_SJ_TO_I_INC_I;

                WR_SJ_TO_I_INC_I: state <= CHECK_I;

                CHECK_I: if   (i[8]) state <= DONE;
                         else        state <= RD_SI;

                DONE: state <= IDLE;

                default: state <= IDLE;
            endcase

    assign        inc_i = state[8];
    assign   sel_addr_j = state[7];
    assign   sel_data_j = state[6];
    assign        wr_en = state[5];
    assign store_data_i = state[4];
    assign store_data_j = state[3];
    assign      store_j = state[2];
    assign       fsm_on = state[1];
    assign   fin_strobe = state[0];
endmodule
