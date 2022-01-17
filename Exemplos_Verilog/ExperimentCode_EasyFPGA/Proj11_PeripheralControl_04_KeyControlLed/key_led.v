/*
** key_led.v
**
**
*/


module key_led( input wire [3:0] KEY, output wire [3:0] LED );
		// Declarar variaveis
		reg [3:0]led_r;
		reg [3:0]buffer;
		
		// Acender os LEDs de acordo com o valor de 'led_r'
		assign LED = led_r;
		
		// Bloco always executado a cada mudanca nos valores de KEY
		always @ ( KEY )
		begin
			// Valor da variavel 'buffer'
			buffer = KEY;
			
			// Estrutura case:
			case( buffer )
				4'b1110: led_r=4'b1110; //Se tecla 0 pressionada, acende LED 0.
				4'b1101: led_r=4'b1101; //Se tecla 1 pressionada, acende LED 1.
				4'b1011: led_r=4'b1011; //Se tecla 2 pressionada, acende LED 2.
				4'b0111: led_r=4'b0111; //Se tecla 3 pressionada, acende LED 3.
				default: led_r=4'b1111; //Caso padrao: os 4 LEDs desligados
			endcase
		end
endmodule
