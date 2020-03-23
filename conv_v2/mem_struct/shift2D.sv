module shift2D#(
    parameter pDATA_W    = ,
    parameter pX_Y_SIZES = 
)(
    input                                   iclk,

    input [pX_Y_SIZES][pDATA_W]             ix_data,
    input [pX_Y_SIZES][pDATA_W]             iy_data,
    input                                   ix_data_en,
    input                                   iy_data_en,

    output [pX_Y_SIZES*pX_Y_SIZES][pDATA_W] odata
);

    //     
    logic [pX_Y_SIZES][pX_Y_SIZES][pDATA_W]          data_matrix;

    always_ff @(posedge iclk) begin
        if ( ix_data_en ) begin
            for ( int i=0; i<pX_Y_SIZES-1; i++ ) begin
                if ( i == 0 ) begin 
                    data_matrix[0]   <= ix_data;
                    data_matrix[i+1] <= data_matrix[i];
                end
                else begin 
                    data_matrix[i+1] <= data_matrix[i];
                end
            end
        end 
        else if ( iy_data_en ) begin 
            for ( int i = 0; i <pX_Y_SIZES-1; i++ ) begin 
                for ( int j = 0; j <pX_Y_SIZES-1; j++ ) begin
                    if (i == 0) begin 
                        data_matrix[0][0]     <= iy_data[j];
                        data_matrix[i+1][j+1] <= data_matrix[i][j];
                    end
                    else begin< 
                        data_matrix[i+1][j+1] <= data_matrix[i][j];
                    end
                end 
            end 
        end
        else begin // 00 and 11 case
            // pass
        end
    end

    always_comb begin : DataMat2Out
        for ( int i=0; i<(pX_Y_SIZES*pX_Y_SIZES-1); i++ ) begin
            odata[i] = data_matrix[][];
        end 
    end

endmodule