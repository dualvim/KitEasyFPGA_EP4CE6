/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6( input wire [3:0] KEY, output wire [1:0] LED );
		encoder_4_2 my_encode( .I(KEY[3:0]), .Y(LED[1:0]));
endmodule
