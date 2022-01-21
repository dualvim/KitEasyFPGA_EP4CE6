/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6(input wire FPGA_CLK, output wire [3:0] DIG, output wire [7:0] SEG );
		sled obj_7seg_dsp( .clock(FPGA_CLK), .segs(SEG), .digs(DIG) );
endmodule
