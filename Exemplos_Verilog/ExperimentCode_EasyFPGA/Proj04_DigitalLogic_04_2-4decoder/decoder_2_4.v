/*
** decoder_2_4.v
**
**
*/

module decoder_2_4( input wire [1:0] I, input wire E, output wire [3:0] Y );
		reg [3:0] y_r;
		// Bloco always
		always @ ( I, E )
		begin
			// Se o botao E tiver pressionado
			if( E ) begin
				y_r = 4'b0000; // Todos ligados
			end
			else begin
				// Case
				case(I)
					2'b00:  y_r = 4'b0111;  // So o LED 0 ligado
					2'b01:  y_r = 4'b1011;  // So o LED 1 ligado
					2'b10:  y_r = 4'b1101;  // So o LED 2 ligado
					2'b11:  y_r = 4'b1110;  // So o LED 3 ligado
					default: y_r = 4'b1111;  // Todos desligados
				endcase
			end
		end
		
		// Atribuicao a Y
		assign Y = y_r;
endmodule
