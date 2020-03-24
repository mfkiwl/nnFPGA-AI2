module add3_3#(
    parameter pDATA_W = 8
)(
    input                           iclk ,
    input                           ien  ,
    input        [8:0][pDATA_W-1]   idata,
    output logic [(pDATA_W*2)-1:0]  odata
);

    localparam          lpNUM = 8;
    localparam          lpINT_W = pDATA_W + 4;

    logic [lpNUM-1:0][lpINT_W-1:0]      pre_adders;
    logic [2:0][lpINT_W-1:0]             data_9;



    always_ff @( posedge iclk ) begin : blockName
        if ( ien ) begin 
            pre_adders[0] <= idata[0] + idata[1];               // clk0
            pre_adders[1] <= idata[2] + idata[3];
            pre_adders[2] <= idata[4] + idata[5];
            pre_adders[3] <= idata[6] + idata[7];
            data_9[0]     <= idata[8];

            pre_adders[4] <= pre_adders[0] + pre_adders[1];     // clk1
            pre_adders[5] <= pre_adders[2] + pre_adders[3];
            data_9[1]     <= data_9[0];  

            pre_adders[6] <= pre_adders[4] + pre_adders[5];     // clk2
            data_9[2]     <= data_9[1];

            pre_adders[7] <= pre_adders[6] + data_9[2];         // clk4

            odata <= pre_adders[7] / 16;
        end
    end


endmodule