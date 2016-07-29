`timescale 1ns / 1ps
module horizontal_count
	#(parameter SYNC_PULSE = 11'd136,
					WHOLE_LINE = 11'd1328,
					FRONT_PORCH = 11'd24,
					BACK_PORCH = 11'd144,
					VISIBLE_AREA = 11'd1024
					)(
	input slow_clock,
	output [10:0] out_horizontal_counter,
	output reg enable_display_horizontally,
	output reg hsync
    );
	 
  reg [10:0] horizontal_counter = 0;
	always @ (posedge slow_clock) begin
		if (horizontal_counter < SYNC_PULSE - 1) 
			hsync <= 0;
		else 
			hsync <= 1;
		if (horizontal_counter == WHOLE_LINE - 1)
			horizontal_counter <= 0;
		else
			horizontal_counter <= horizontal_counter + 1;
		if ((horizontal_counter < SYNC_PULSE + FRONT_PORCH - 1) || (horizontal_counter > VISIBLE_AREA + SYNC_PULSE + FRONT_PORCH - 1))
			enable_display_horizontally <= 0;
		else
			enable_display_horizontally <= 1;
	end
	
	assign out_horizontal_counter = horizontal_counter;

endmodule