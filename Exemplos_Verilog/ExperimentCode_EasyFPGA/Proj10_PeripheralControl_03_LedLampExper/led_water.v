/*
** led_water.v
**
** 
*/

module led_water( input wire FPGA_CLK, output reg [3:0] LED );
		// Sinal do clock
		wire clk = FPGA_CLK;
		
		// Contador usado como variavel intermediaria
		reg [24:0] counter;
		
		// Bloco always executado nas brdas de subda do clock
		always @ ( posedge clk )
		begin
				// Incrementar 'counter'
				counter <= counter + 1;
				
				// Se o valor de counter for 25.000.000
				if( counter == 25'd25000000 ) begin
						LED <= LED<<1;
						// Zerar 'counter'
						counter <= 0;
						
						// Se os 4 LEDs estiverem acesos:
						if( LED == 4'b0000) begin
								LED <= 4'b1111; // Apagar os 4 LEDs
						end
				end	
		end
endmodule
