module compute_fsm(
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic stop,

    output logic [1:0] sel_addr_s_mem,
    output logic       sel_data_s_mem,
    output logic       wr_en,
    output logic       wr_en_dec,
    output logic       inc_i,
    output logic       store_j,
    output logic       store_s_i,
    output logic       store_s_j,
    output logic       store_f,
    output logic       inc_k,
    output logic       store_enc_k,

    output logic fsm_on,
    output logic fin_strobe
);

    typedef enum logic [17:0] {
                      IDLE = 18'b0000_000000000000_00,
                     INC_I = 18'b0001_000001000000_10,
                     RD_SI = 18'b0010_000000000000_10,
              STR_SI_AND_J = 18'b0011_000000110000_10,
                     RD_SJ = 18'b0100_010000000000_10,
        STR_SJ_WR_SI_TO_SJ = 18'b0101_010100001000_10,
               WR_SJ_TO_SI = 18'b0110_001100000000_10,
             RD_F_AND_ENCK = 18'b0111_100000000000_10,
            STR_F_AND_ENCK = 18'b1000_000000000101_10,
            STR_DECK_INC_K = 18'b1001_000010000010_10,
                   CHECK_K = 18'b1010_000000000000_00,
                      DONE = 18'b1011_000000000000_01
    } statetype;

    statetype state;

    always_ff @(posedge clk)
        if (rst)
            state <= IDLE;
        else
            case (state)
                IDLE: if   (start) state <= INC_I;
                      else         state <= IDLE;

                             INC_I: state <= RD_SI;
                             RD_SI: state <= STR_SI_AND_J;
                      STR_SI_AND_J: state <= RD_SJ;
                             RD_SJ: state <= STR_SJ_WR_SI_TO_SJ;
                STR_SJ_WR_SI_TO_SJ: state <= WR_SJ_TO_SI;
                       WR_SJ_TO_SI: state <= RD_F_AND_ENCK;
                     RD_F_AND_ENCK: state <= STR_F_AND_ENCK;
                    STR_F_AND_ENCK: state <= STR_DECK_INC_K;
                    STR_DECK_INC_K: state <= CHECK_K;

                CHECK_K: if   (stop) state <= DONE;
                         else        state <= INC_I;

                DONE: state <= IDLE;
            endcase

    assign sel_addr_s_mem = state[13:12];
    assign sel_data_s_mem = state[11];
    assign          wr_en = state[10];
    assign      wr_en_dec = state[9];
    assign          inc_i = state[8];
    assign        store_j = state[7];
    assign      store_s_i = state[6];
    assign      store_s_j = state[5];
    assign        store_f = state[4];
    assign          inc_k = state[3];
    assign    store_enc_k = state[2];

    assign         fsm_on = state[1];
    assign     fin_strobe = state[0];
endmodule
