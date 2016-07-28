`timescale 1ns / 1ps

module MAP( input [10:0] POS_X,
            input [10:0] POS_Y,
            input DISPLAY_EN,
            output reg [5:0] XMAP,
            output reg [4:0] YMAP
    );

    reg [10:0] regX, regY;
    
    always@ (*) begin
        if(DISPLAY_EN) begin
            regX = POS_X - 159;
            regY = POS_Y - 3;
            
            XMAP = regX[10:5];
            YMAP = regY[10:5];
        end
    end

endmodule
