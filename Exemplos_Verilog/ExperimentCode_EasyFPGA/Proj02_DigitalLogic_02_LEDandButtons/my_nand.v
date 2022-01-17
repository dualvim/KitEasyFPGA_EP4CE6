module my_nand(input wire [3:0] KEY, output wire [1:0] LED);
	// Fios conectados aos botoes
	wire a = ~KEY[0];
	wire b = ~KEY[1];
	
	// Atribuicao do valor em 'LED[0]'
	assign LED[0] = ~(a & b);
	assign LED[1] = 1;
endmodule
