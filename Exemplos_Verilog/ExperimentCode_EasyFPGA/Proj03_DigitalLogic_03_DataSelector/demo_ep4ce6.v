/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6( input wire [3:0] KEY, output wire [0:0] LED );
		mux_2_1 my_mux( .sel(KEY[2]), .A(KEY[0]), .B(KEY[1]), .L(LED[0]) );
endmodule
