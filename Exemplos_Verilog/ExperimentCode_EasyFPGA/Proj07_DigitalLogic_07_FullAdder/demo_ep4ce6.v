/*
** demo_ep4ce6.v
**
**
*/


module demo_ep4ce6( input wire [3:0] KEY, output wire [1:0] LED );
		wire soma, carry;
		full_adder somador(KEY[0], KEY[1], KEY[2], soma, carry);
		assign LED[0] = soma;
		assign LED[1] = carry;
endmodule
