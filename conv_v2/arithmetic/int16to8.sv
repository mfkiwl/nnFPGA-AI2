module int16to8 #(
    parameter pTYPE_OF_TRANSFOR = "lin"             // possible types are lin, log
)(
    input                   iclk ,
    input        [15:0]     idata,
    output logic [7:0]      odata
);
    

    generate 
        if ( pTYPE_OF_TRANSFOR == "lin" ) begin
            always_ff @( posedge iclk ) begin 
                odata <= idata / 8'd255;
            end    
        end
        else if ( pTYPE_OF_TRANSFOR == "log" ) begin // poscitat isho
            always_ff @( posedge iclk ) begin 
                if ( idata < 16'd255 ) begin        //  0-127
                    odata <= {1'b0, idata[6:0]};
                end
                else if ( idata < 16'd511 ) begin   // 128 - 191
                    odata <= idata[8:1] + 8'd128;
                end
                else if ( idata < 16'd1023 ) begin  // 192 - 223
                    odata <= idata[9:2] + 8'd192;
                end
                else if ( idata < 16'd2043 ) begin  // 224 - 239
                    odata <= idata[10:3] + 8'd224;
                end
                else if ( idata < 16'd4047 ) begin  // 240 - 247
                    odata <= idata[11:4] + 8'd240;
                end 
                else if ( idata < 16'd8191 ) begin  // 248 - 253
                    odata <= idata[12:5] + 8'd248;
                end
                else if ( idata < 16'd16383 ) begin  // 248 - 253
                    odata <= idata[13:6] + 8'd248';
                end
                else if ( idata < 16'd32767  ) begin  // 248 - 253
                    odata <= idata[14:7] + 8'd248;
                end
                else  begin  // 254 - 255
                    odata <= idata[15:8] + 8'd254;
                end 
            end
        end
    endgenerate 


endmodule