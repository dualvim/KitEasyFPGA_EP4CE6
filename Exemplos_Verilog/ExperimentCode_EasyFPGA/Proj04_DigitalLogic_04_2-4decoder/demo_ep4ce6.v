/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6(input wire [3:0] KEY, output wire [3:0] LED);
		decoder_2_4 my_decoder( .I(KEY[1:0]), .E(KEY[2]), .Y(LED) );
endmodule
