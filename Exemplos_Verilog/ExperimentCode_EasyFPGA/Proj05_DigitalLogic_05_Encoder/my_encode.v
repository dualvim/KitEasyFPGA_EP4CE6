module my_encode(input wire [3:0] KEY, output wire [1:0] LED);
	// Sinais 'I'
	wire [3:0] I = ~KEY[3:0];
	// Saidas Y
	reg [1:0] Y;
	
	// Bloco always para responder mudancas em 'I'
	always @ ( I )
	begin
		casex(I)
			4'b0001:  Y=2'b11; //Se pressionado o botao 4
			4'b001x:  Y=2'b10; //Se pressionado o botao 3
			4'b01xx:  Y=2'b01; //Se pressionado o botao 2
			4'b1xxx:  Y=2'b00; //Se pressionado o botao 1
			default:  Y=2'b11;
		endcase
	end

	// --> Sinais 'LED' irao corresponder ao valor 'Y'
	assign LED = Y[1:0];
endmodule
