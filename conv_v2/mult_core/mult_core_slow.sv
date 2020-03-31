module mult_core_slow #(
    parameter


)(



);


    add_cyclic #(
        .pDATA_IN_W       (       ),
        .pNUM_OF_ELEMENTS ( ),
        .pRESET_TYPE      (pRESET_TYPE      )
    )
        u_add_cyclic(
            .iclk        (iclk        ),
            .irst        (irst        ),
            .idata       (idata       ),
            .idata_en    (idata_en    ),
            .odata       (odata       ),
            .odata_ready (odata_ready )
    );
    




endmodule