/*
** led_twinkle.v
**
** --> Faz os 4 LEds piscarem em uma determinada frequencia
**/

module led_twinkle(input wire FPGA_CLK, output reg [3:0] LED);
	// Sinal do clock
	wire clk = FPGA_CLK;
	
	// Contador usado como variavel intermediaria
	reg [24:0] counter = 0;
	// Iterador que ira indicar quais LEDs deverao ser acendidos
	reg [3:0] iter = 0;
	
	// Bloco always executado nas brdas de subda do clock
	always @ ( posedge clk )
	begin
		// Incrementar 'counter'
		counter <= counter + 1;
		
		// Se o valor de counter for 25.000.000
		if( counter == 25'd25000000 ) begin
			// Incrementar 'iter'
			if( iter < 7 ) begin
				iter = iter + 1;
			end
			else begin
				iter = 0;
			end
			
			
			// Acender os LEDs de acordo com 'iter'
			case(iter)
				4'd1: LED<=4'b0001;
				4'd2: LED<=4'b0011;
				4'd3: LED<=4'b0111;
				4'd4: LED<=4'b1111;
				4'd5: LED<=4'b0111;
				4'd6: LED<=4'b0011;
				4'd7: LED<=4'b0001;
				default: LED<=4'b0000;
			endcase

			// Reiniciar 'counter'
			counter <= 0;
		end
	end
endmodule
