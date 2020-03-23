module add_cyclic #(
    parameter pDATA_IN_W        = 8,
    parameter pNUM_OF_ELEMENTS  = 9,  
    parameter pDATA_OUT_W       =   ( pNUM_OF_ELEMENTS <= 2  ) ? pDATA_IN_W + 1 : 
                                  ( ( pNUM_OF_ELEMENTS <= 4  ) ? pDATA_IN_W + 2 : 
                                  ( ( pNUM_OF_ELEMENTS <= 8  ) ? pDATA_IN_W + 3 :
                                  ( ( pNUM_OF_ELEMENTS <= 16 ) ? pDATA_IN_W + 4 : 
                                  ( ( pNUM_OF_ELEMENTS <= 32 ) ? pDATA_IN_w + 5 : pDATA_IN_W ))))
    parameter pRESET_TYPE = "auto" // "manual" 

)(
    input              iclk,
    input   irst, 

    input [pDATA_IN_W-1:0]      idata    , 
    input                       idata_en ,

    output logic [pDATA_OUT_W-1:0]    odata      ,
    output logic                     odata_ready

);

    logic [$clog2(pNUM_OF_ELEMENTS):0]      elements_cnt;


    generate
        if ( pRESET_TYPE == "auto" ) begin 

            always_ff @( posedge iclk ) begin : MainBlockAuto
                if ( irst ) begin 
                    odata        <=  'd0;     
                    odata_ready  <= 1'b0; 
                    elements_cnt <=  'd0;
                end
                else begin 
                
                    if ( idata_en ) begin
                        if ( elements_cnt != pNUM_OF_ELEMENTS-1 ) begin 
                            odata_ready <= 1'b0;
                            odata   <= odata + idata;
                            elements_cnt <= elements_cnt + 'd1;
                        end
                        else begin 
                            odata_ready <= 1'b0;
                        end
                    end
                    else begin 

                        if ( odata_ready ) begin 
                            odata       <=  'd0;     
                            odata_ready <= 1'b0;
                        end

                    end

                end
            end

        end
        else if ( pRESET_TYPE == "manual" ) begin

            always_ff @( posedge iclk ) begin : blockName
                
            end


        end
        else begin 

        end
    endgenerate


endmodule 