/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6( input wire FPGA_CLK, output wire [3:0] LED );
	led_twinkle piscar ( .clk(FPGA_CLK), .leds(LED) );
endmodule
