module button_sync(
    input  logic clk,
    input  logic rst,
    input  logic async_sig,
    output logic sync_sig
);
    
    typedef enum logic [2:0] {
                IDLE = 3'b00_0,
          ASSERT_SIG = 3'b01_1,
        DEASSERT_SIG = 3'b10_0
    } statetype;

    statetype state;

    always_ff @(posedge clk)
        if (rst) 
            state <= IDLE;
        else
            case (state)
                IDLE: if   (async_sig) state <= ASSERT_SIG;
                      else             state <= IDLE;

                ASSERT_SIG: state <= DEASSERT_SIG;

                DEASSERT_SIG: if   (rst) state <= IDLE;
                              else       state <= DEASSERT_SIG;
            endcase

    assign sync_sig = state[0];
endmodule