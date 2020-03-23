module C2D_main_fsm#(
    parameter pVEC_X = 28,
    parameter pVEC_Y = 28,
    parameter pKER_X = 3 ,
    parameter pKER_Y = 3 

)(
    input iclk, 
    input irst, 

    output icalc_en, 

);

    localparam          lpCLK2_F_WIN  = pKER_X*pKER_Y;
    localparam          lpCLK2_F_LINE = pKER_Y       ;
    localparam          lpCLK2_N_ELEM = pKER_X       ;
    localparam          lpCLK2_N_LINE = 1            ;

    localparam          lpTIMES_F_WIN  = 1                   ;
    localparam          lpTIMES_F_LINE = pVEC_X-3            ; // шаг единичный
    localparam          lpTIMES_N_ELEM = pVEC_Y-3            ;
    localparam          lpTIMES_N_LINE = (pVEC_X-)*(pVEC_Y-) ;


    logic [:0]              counter_to_en    ;
    logic [:0]              counter_to_repeat;


    // state description 
    // sWAIT
    enum logic { sWAIT, sF_WINDOW, 
                 sF_LINE, sN_ELEM, sN_LINE, sEND } state, next_state;


    always_ff @(posedge iclk) begin
        if (irst) begin 

        end
        else begin 

            case(state)
                sWAIT    : begin
                    
                end
                sF_WINDOW: begin
                    
                end
                sF_LINE  : begin
                    
                end
                sN_ELEM  : begin
                    
                end
                sN_LINE  : begin
                    
                end
                sEND     : begin
                    
                end

            endcase

        end
    end


    always_comb 
        
    end


endmodule