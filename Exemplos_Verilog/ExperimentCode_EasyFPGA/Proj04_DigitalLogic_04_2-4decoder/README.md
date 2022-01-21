# Lógica Digital - Projeto 4 - `my_decode`       
![Projeto em funcionamento](./Proj04_DigitalLogic_04_2-4decoder.gif)       
       

# Código do projeto     
         

## Módulo `decoder_2_4`      
```verilog     
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
```         
        

## Módulo principal:      
```verilog
module demo_ep4ce6(input wire [3:0] KEY, output wire [3:0] LED);
		decoder_2_4 my_decoder( .I(KEY[1:0]), .E(KEY[2]), .Y(LED) );
endmodule
```     
        