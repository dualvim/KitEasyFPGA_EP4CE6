module full_adder(input wire [3:0] KEY, output wire [1:0] LED);
	// Inputs do somador
	wire A = ~KEY[0];
	wire B = ~KEY[1];
	wire Ci = ~KEY[2];  // Carry-In
	
	// Outputs dos meio-somadores
	wire C0, C1, S0, S1;
	
	// Carry-out do somador
	wire Co = C0 | C1;
	
	// Half-adder 0:
	half_adder half_adder_0(.A(A), .B(B), .S(S0), .C(C0));
	
	// Half-adder 1:
	half_adder half_adder_1(.A(S0), .B(Ci), .S(S1), .C(C1));
	
	// LEds
	assign LED[1] = ~S1;
	assign LED[0] = ~Co;
endmodule
