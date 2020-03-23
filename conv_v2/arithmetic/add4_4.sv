module add4_4#(
    parameter pDATA_W = 8
)(
    input                       iclk,
    input                       ien ,
    input [15:0][pDATA_W-1]     idata,
    output [(pDATA_W*2)-1:0]    odata,
);

    localparam          lpNUM = 14;

    logic [lpNUM-1:0][(pDATA_W*2)-1:0]      pre_adders

    always_ff @( posedge iclk ) begin : blockName
        if ( ien ) begin 
            pre_adders[0] <= idata[0 ] + idata[1 ];               // clk0
            pre_adders[1] <= idata[2 ] + idata[3 ];
            pre_adders[2] <= idata[4 ] + idata[5 ];
            pre_adders[3] <= idata[6 ] + idata[7 ];
            pre_adders[4] <= idata[8 ] + idata[9 ];
            pre_adders[5] <= idata[10] + idata[11];
            pre_adders[6] <= idata[12] + idata[13];
            pre_adders[7] <= idata[14] + idata[15];

            pre_adders[8]  <= pre_adders[0] + pre_adders[1];     // clk1
            pre_adders[9]  <= pre_adders[2] + pre_adders[3];
            pre_adders[10] <= pre_adders[4] + pre_adders[5];
            pre_adders[11] <= pre_adders[6] + pre_adders[7];

            pre_adders[12] <= pre_adders[4] + pre_adders[5];     // clk2
            pre_adders[13] <= pre_adders[4] + pre_adders[5];     // clk2

            odata          <= pre_adders[12] + idata[13]];         // clk4
        end
        
    end


endmodule