/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6( input wire FPGA_CLK, output wire FPGA_BUZZER );
		beep meu_buzzer( .clk(FPGA_CLK), .buzzer(FPGA_BUZZER) );
endmodule
