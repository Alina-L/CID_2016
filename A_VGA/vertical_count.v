
`timescale 1ns / 1ps

module vertical_count #(parameter SYNC_PULSE   = 11'd6,
											 WHOLE_FRAME  = 11'd806,
											 FRONT_PORCH  = 11'd3,
											 BACK_PORCH   = 11'd29,
											 VISIBLE_AREA = 11'd768
	)(
	input 		slow_clock,
	input enable,
	output [10:0] out_vertical_counter,
	output reg enable_display_vertically,
	output reg vsync
    );
	 reg [10 : 0] vertical_counter = 0;
	 
	always @ (posedge enable) begin
			if (vertical_counter < SYNC_PULSE) 
				vsync <= 0;
			else 
				vsync <= 1;
			if (vertical_counter == WHOLE_FRAME)
				vertical_counter <= 0;
			else
				vertical_counter <= vertical_counter + 1;
			if ((vertical_counter < SYNC_PULSE + FRONT_PORCH) || (vertical_counter > VISIBLE_AREA + FRONT_PORCH + SYNC_PULSE))
				enable_display_vertically <= 0;
			else
				enable_display_vertically <= 1;
	end
	
	assign out_vertical_counter= vertical_counter;

endmodule