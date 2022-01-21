/*
** full_adder.v
**
** --> Somador completo de 1 bit
*/

module full_adder(input wire A, B, Ci, output wire S, Co);
	// Outputs dos meio-somadores
	wire C0, C1, S0, S1;
	
	// Carry-out do somador
	assign Co = C0 | C1;
	
	// Half-adder 0:
	half_adder half_adder_0(.A(A), .B(B), .S(S0), .C(C0));
	
	// Half-adder 1:
	half_adder half_adder_1(.A(S0), .B(Ci), .S(S1), .C(C1));
endmodule