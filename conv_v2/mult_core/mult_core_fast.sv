// number of multipliers equals kernel size 











module mult_core_fast#(
    parameter pDATA_W   = 8,
    parameter pKERNEL_X = 3,
    parameter pKERNEL_Y = 3
)(

    input                                           iclk        , 
    input                                           irst        ,

    input [pKERNEL_Y][pKERNEL_X][pDATA_W-1:0]       idata       ,
    input [pKERNEL_Y][pKERNEL_X][pDATA_W-1:0]       idata_kernel,
    input                                           icalc_en    ,

    output logic [pDATA_W-1:0]                      odata 
);

    import mult_core_package::pTYPE_OF_TRANSFORM;


    localparam lpMULT_RES_W = $clog2(pKERNEL_Y*pKERNEL_X);
    localparam lp ;
    localparam lp ;

    logic [lpMULT_RES_W][pDATA_W-1:0]               mult_results;
    logic [lpMULT_RES_W][pDATA_W*2-1:0]             post_mult_results;    

    generate;
        if ( (pKERNEL_X == 2) && (pKERNEL_Y == 2) ) begin
            add2_2 #(
                .pDATA_W (pDATA_W )
                ) u_add2_2(
            	    .iclk  ( iclk         ),
                    .ien   ( icalc_en     ),
                    .idata ( mult_results ),
                    .odata (  )
            );
        end
        else if ( (pKERNEL_X == 3) && (pKERNEL_Y == 3) ) begin 
            add3_3 #(
                .pDATA_W (pDATA_W )
                ) u_add3_3(
            	    .iclk  ( iclk         ),
                    .ien   ( icalc_en     ),
                    .idata ( mult_results ),
                    .odata (      )
            );
        end
        else if ( (pKERNEL_X == 4) && (pKERNEL_Y == 4) ) begin 
            add4_4 #(
                .pDATA_W (pDATA_W )
                ) u_add4_4(
            	    .iclk  (  ),
                    .ien   ( icalc_en ),
                    .idata (  ),
                    .odata (  )
            );
        end
        else if ( (pKERNEL_X == 1) && (pKERNEL_Y == 1) ) begin 

        end
        else begin 
            // pass
        end

        if ( pDATA_W == 8 ) begin 
            for ( int i = 0; i < pDATA_W; i++ ) begin
                int16to8 #(
                    .pTYPE_OF_TRANSFORM (pTYPE_OF_TRANSFORM )
                )
                u_int16to8(
                    .iclk  ( iclk                 ),
                    .idata ( post_mult_results[i] ),
                    .odata ( mult_results[i]      )
                );
            end 
        end
        else if ( pDATA_W == 16 ) begin
            for ( int i = 0; i < pDATA_W, i++ ) begin
                int32to16 #(
                    .pTYPE_OF_TRANSFORM (pTYPE_OF_TRANSFORM )
                )
                u_int32to16 (
                	.iclk  ( iclk                 ),
                    .idata ( post_mult_results[i] ),
                    .odata ( mult_results[i]      )
                );
                
            end 
        end 
        else begin 
            // pass

        end

    endgenerate


    always_ff @( posedge iclk ) begin : MainBlock
        if ( irst ) begin 

        end
        else begin 
            if ( icalc_en ) begin 
            
                // multiplication
                for( int i=0; i< ; i++ ) begin
                    for( int j=0; j< ; j++ ) begin 
                        mult_results[i+pKERNEL_X*j] = idata_kernel[i][j]*idata[i][j];
                    end
                end


            end
        end
    end



endmodule 