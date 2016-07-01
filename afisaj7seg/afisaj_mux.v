`timescale 1ns / 1ps
module digit_multiplexer (
				input reset,
				input clock,
				input[7:0] sw,
				output[7:0] out_seg,
				output[3:0] out_sel
			           );

afisaj7s seg1(
		.cifra0(sw[1:0]),
		.cifra1(sw[3:2]),
		.cifra2(sw[5:4]),
		.cifra3(sw[7:6]),
		.reset(reset),
		.clock(clock),
		.out_sel(out_sel),
		.out_seg(out_seg)
		);

endmodule //digit_multiplexer

module afisaj7s(
		input reset,
		input clock,
		input[3:0] cifra0,
		input[3:0] cifra1,
		input[3:0] cifra2,
		input[3:0] cifra3,
		output[3:0] out_sel,
		output[7:0] out_seg
);
		wire[1:0] w_out_counter;
		wire[3:0] w_out_mux;

counter counter0 (
		        .reset (reset),
		        .clock (clock),
		        .out (w_out_counter)
		       );

decoder decoder1 (
		          .in (w_out_counter),
		          .out (out_sel)
		         );

mux mux0 (
	         .select (w_out_counter),
	         .in0 (cifra0),
	         .in1 (cifra1),
	         .in2 (cifra2),
	         .in3 (cifra3),
	         .out (w_out_mux)
	        );

transcodor transcodor0 (
			        .in (w_out_mux),
			        .out_seg (out_seg)
			       );

endmodule //afisaj7s

module counter (
		       input reset,
		       input clock,
		       output wire[1:0] out
		      );

		       reg[18:0] count;

always @ (posedge clock or posedge reset) 
	begin
     		if (reset) 
			begin
        				count <= 0;   
     			end else 
			begin
        				count <= count + 1;
     			end
	end

assign out = count[18:17];

endmodule //counter


module mux (
		 input[1:0] select,
		 input[3:0] in0,
		 input[3:0] in1,
		 input[3:0] in2,
		 input[3:0] in3,
	 	 output reg[3:0] out
		);

always @ (*) 
	begin 
		case (select)
			2'b00: out <= in0;
			2'b01: out <= in1;		
			2'b10: out <= in2;		
			2'b11: out <= in3;				
		endcase	
	end

endmodule //mux


module decoder (
		       input[1:0] in,
               	       output[3:0] out
		      );
     
assign out = ~(1 << in);

 endmodule //decoder


module transcodor (
			input[3:0] in,
			output reg[7:0] out_seg
			); 
 
always @ (*) 
	begin
		case (in) 
			4'h0 : out_seg = 8'b00000011;
			4'h1 : out_seg = 8'b10011111;
			4'h2 : out_seg = 8'b00100101;
			4'h3 : out_seg = 8'b00001101;
			4'h4 : out_seg = 8'b10011001;
			4'h5 : out_seg = 8'b01001001;
			4'h6 : out_seg = 8'b01000001;
			4'h7 : out_seg = 8'b00011111;
			4'h8 : out_seg = 8'b00000001;
			4'h9 : out_seg = 8'b00001001;	
			4'hA : out_seg = 8'b00010001;
			4'hB : out_seg = 8'b11000001;
			4'hC : out_seg = 8'b01100011;
			4'hD : out_seg = 8'b10000011;
			4'hE : out_seg = 8'b01100001;
			4'hF : out_seg = 8'b01110001;
		endcase
	end	

endmodule //transcodor