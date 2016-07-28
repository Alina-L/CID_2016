`timescale 1ns / 1ps

module actual_top(  input LEFT,
                    input RIGHT,
                    input CLK,
                    input RST_IN,
                    output [2:0] R,
                    output [2:0] G,
                    output [1:0] B,
                    output HSYNC,
                    output VSYNC
);

wire POS_X, POS_Y;
wire DISPLAY_EN;
wire [5:0] XMAP;
wire [4:0] YMAP;
    
top vga (
		.FCLK(CLK),
		.PIXEL_DATA(PIXEL_DATA),
		.DISPLAY_EN(DISPLAY_EN),
		.POS_X(POS_X),
		.POS_Y(POS_Y),
		.R(R),
		.G(G),
		.B(B),
		.HSYNC(HSYNC),
		.VSYNC(VSYNC),
		.RST_IN(RST_IN));
    
MAP map(.POS_X(POS_X), 
        .POS_Y(POS_Y), 
        .DISPLAY_EN(DISPLAY_EN),
        .XMAP(XMAP),
        .YMAP(YMAP));

// if (left^right)      if (left) paddle_pos -= 1 else paddle_pos += 1

    always@(*) begin
          if (((XMAP >= 5 || XMAP <= 40) && (YMAP == 1 || YMAP == 31))||
                ((YMAP >= 1 || YMAP <= 31) && (XMAP == 5 || XMAP == 40)))
                        PIXEL_DATA[7:0] = 8'b11111111;  
          else          PIXEL_DATA[7:0] = 8'b00000000; 
    end
endmodule
