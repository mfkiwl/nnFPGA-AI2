module int32to16(

    input                   iclk ,
    input        [31:0]     idata,
    output logic [15:0]     odata,

);


    always_ff @( posedge iclk ) begin
        odata <= ( idata / 16'hffff );
    end


endmodule 