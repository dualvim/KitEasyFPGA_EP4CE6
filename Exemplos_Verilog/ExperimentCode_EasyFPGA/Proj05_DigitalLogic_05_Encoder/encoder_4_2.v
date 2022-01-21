/*
** encoder_4_2.v
**
**
*/

module encoder_4_2(input wire [3:0] I, output wire [1:0] Y );
	reg [1:0] y_r;
	
	always @ ( I )
	begin
		casex( I )
			4'b1110 : y_r = 2'b00; //Se pressionado o botao 4
			4'b110x : y_r = 2'b10; //Se pressionado o botao 3
			4'b10xx : y_r = 2'b01; //Se pressionado o botao 2
			4'b0xxx : y_r = 2'b11; //Se pressionado o botao 1
			default : y_r = 2'b11; 
		endcase
	end
	
	// Atribuicao para 'Y'
	assign Y = y_r;
endmodule
