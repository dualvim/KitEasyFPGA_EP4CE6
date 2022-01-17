module my_mux(input wire [3:0] KEY, output wire [1:0] LED);
	// Fios conectados aos botoes
	wire a = ~KEY[0];
	wire b = ~KEY[1];
	
	// Seletor do mux
	wire sel = ~KEY[2];
	
	// Estado do LED
	assign LED[0] = sel ? b : a;
	assign LED[1] = 1;
endmodule
