module add_cyclic #(
    parameter pDATA_IN_W        = 8,
    parameter pNUM_OF_ELEMENTS  = 9,  
    parameter pRESET_TYPE = "auto" // "manual" 

)(
    input                               iclk,
    input                               irst, 

    input [pDATA_IN_W-1:0]              idata    , 
    input                               idata_en ,

    output logic [pDATA_IN_W-1:0]       odata      ,
    output logic                        odata_ready

);

    localparam      lpINT_W = pDATA_IN_W + $clog2(pNUM_OF_ELEMENTS) + 1;
    localparam      lpCONST_DIV = $clog2(pNUM_OF_ELEMENTS);


    logic [$clog2(pNUM_OF_ELEMENTS):0]      elements_cnt;
    logic [lpINT_W-1:0]                     acc;

    generate
        if ( pRESET_TYPE == "auto" ) begin 

            always_ff @( posedge iclk ) begin : MainBlockAuto
                if ( irst ) begin 
                    odata        <=  'd0;     
                    odata_ready  <= 1'b0; 
                    elements_cnt <=  'd0;
                    acc          <=  'd0;
                end
                else begin 
                
                    if ( idata_en ) begin
                        if ( elements_cnt != pNUM_OF_ELEMENTS-1 ) begin 
                            odata_ready  <= 1'b0   ;
                            acc          <= odata + idata;
                            elements_cnt <= elements_cnt + 'd1;
                        end
                        else if ( elements_cnt == pNUM_OF_ELEMENTS ) begin 
                            odata      <= acc / lpCONST_DIV;
                        end 
                        else if ( odata_ready ) begin 
                            odata       <=  'd0;
                            acc         <=  'd0;     
                            odata_ready <= 1'b0;
                        end
                        else begin 
                            odata_ready <= 1'b0;
                        end
                    end
                    else begin 

                        if ( odata_ready ) begin 
                            odata       <=  'd0;     
                            odata_ready <= 1'b0;
                            acc         <=  'd0;
                        end

                    end

                end
            end

        end
        else if ( pRESET_TYPE == "manual" ) begin                           //  CHECK the adder in future 

            always_ff @( posedge iclk ) begin : blockName
                if ( irst ) begin 
                    odata        <=  'd0;
                    acc          <=  'd0;
                    elements_cnt <=  'd0;
                    odata_ready  <= 1'b0;
                end
                else begin
                    if ( idata_en ) begin
                        if ( elements_cnt != pNUM_OF_ELEMENTS-1 ) begin 
                            odata_ready  <= 1'b0   ;
                            acc          <= odata + idata;
                            elements_cnt <= elements_cnt + 'd1;
                        end
                        else if ( elements_cnt == pNUM_OF_ELEMENTS ) begin 
                            odata      <= acc / lpCONST_DIV;
                        end 
                        else begin 
                            odata_ready <= 1'b0;
                        end
                    end
                end 
            end


        end
        else begin 
                // PASS
        end
    endgenerate


endmodule 