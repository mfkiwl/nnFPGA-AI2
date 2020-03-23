module add2_2#(
    parameter pDATA_W = 8
)(
    input                               iclk ,
    input                               ien  , 
    input        [3:0][pDATA_W-1:0]     idata,
    output logic [(pDATA_W*2)-1:0]      odata 
);

    localparam          lpNUM = 2;

    logic [lpNUM-1:0][pDATA_W-1:0]      pre_adders

    always_ff @( posedge iclk ) begin : blockName
        if ( ien ) begin 
            pre_adders[0] <= idata[0] + idata[1];
            pre_adders[1] <= idata[2] + idata[3];
            odata         <= pre_adders[0] + pre_adders[1];
        end
    end

endmodule