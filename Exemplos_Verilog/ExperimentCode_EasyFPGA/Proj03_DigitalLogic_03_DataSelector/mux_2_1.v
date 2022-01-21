/*
** mux_2_1.v
**
**
*/


module mux_2_1( input wire sel, A, B, output wire L );
		// Selecionar o input
		assign L = sel ? B : A;
endmodule
