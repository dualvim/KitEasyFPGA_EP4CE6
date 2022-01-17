module half_adder(input wire A, input wire B, output wire S, output wire C);
		// Sinais referentes aos LEDs
		wire sum = A ^ B;   // Resultado da soma
		wire CO = A & B;   // Resultado do Carry-out
	
		// Acender/apagar os LEDs
		assign S = sum;   // Resultado da soma
		assign C = CO; // Carry-out
endmodule
