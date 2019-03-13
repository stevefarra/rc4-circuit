module shuffle_fsm(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    input  logic [7:0] i,
    output logic       inc_i,
    output logic       sel_addr_i,
    output logic       sel_data_j,
    output logic       wr_en,
    output logic       store_data_i,
    output logic       store_data_j,
    output logic       store_j
    output logic       fsm_on,
    output logic       fin_strobe
);
    //
    typedef enum {
          IDLE,
          RD_SI,
          STR_SI_AND_J,
          READ_SJ,
          STR_SJ_WR_SI_TO_J,
          WR_SJ_TO_I_INC_I,
          DONE
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

                WR_SJ_TO_I_INC_I: if   (&i) state <= DONE;
                                  else      state <= RD_SI;

                DONE: state <= IDLE;

                default: state <= IDLE;
            endcase

    assign wr_and_inc = state[0];
    assign fin_strobe = state[1];
endmodule
