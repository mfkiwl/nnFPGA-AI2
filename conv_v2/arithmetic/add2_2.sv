module add2_2#(
    parameter pDATA_W = 8
)(
    input                               iclk ,
    input                               ien  , 
    input        [3:0][pDATA_W-1:0]     idata,
    output logic [(pDATA_W*2)-1:0]      odata 
);

    localparam          lpNUM   = 2 ;
    localparam          lpINT_W = pDATA_W + 2;        // 8 + 2 due to overflow  

    logic [lpNUM:0][lpINT_W-1:0]      pre_adders

    always_ff @( posedge iclk ) begin : blockName
        if ( ien ) begin 
            pre_adders[0] <= idata[0] + idata[1];
            pre_adders[1] <= idata[2] + idata[3];

            pre_adders[2] <= pre_adders[0] + pre_adders[1];
            // overflow problem 
            odata         <= pre_adders[2] / 4;
        end
    end

endmodule