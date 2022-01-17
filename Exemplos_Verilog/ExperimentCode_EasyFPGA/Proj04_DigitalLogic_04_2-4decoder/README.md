# Lógica Digital - Projeto 4 - `my_decode`       
![Projeto em funcionamento](./Proj04_DigitalLogic_04_2 4decoder.gif)       
       

## Código do projeto     
```verilog     
module my_decode(input wire [3:0] KEY, output wire [3:0] LED);
	// Sinais 'I'
	wire [1:0] I = KEY[1:0];
	// Sinal 'E'
	wire E = ~KEY[2];
	// Saidas Y
	reg [3:0] Y;
	
	// Bloco always
	always @ (I, E)
	begin
		// Se o botao E tiver pressionado
		if( E ) begin
			Y = 4'b0000; // Todos ligados
		end
		else begin
			// Case
			case(I)
				2'b00:  Y=4'b0111;  // So o LED 0 ligado
				2'b01:  Y=4'b1011;  // So o LED 1 ligado
				2'b10:  Y=4'b1101;  // So o LED 2 ligado
				2'b11:  Y=4'b1110;  // So o LED 3 ligado
				default: Y=4'b1111;  // Todos desligados
		endcase
		end
	end
	
	// --> Sinais 'LED' irao corresponder ao valor 'Y'
	assign LED = Y[3:0];
endmodule
```         
        
