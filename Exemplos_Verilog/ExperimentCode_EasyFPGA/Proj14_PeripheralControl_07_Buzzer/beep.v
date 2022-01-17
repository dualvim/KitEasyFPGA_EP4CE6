/*
** beep.v
**
**
*/

module beep( input wire FPGA_CLK, output wire FPGA_BUZZER );
		// Variaveis com os sinais
		wire clk = FPGA_CLK;

		// Declaracao de variaveis
		reg beep_r;
		reg[27:0]count;

		// Estado do Buzzer:
		assign FPGA_BUZZER = beep_r;

		// Bloco always executado a cada borda de subida do clock
		always @ ( posedge clk )
		begin
				// Incrementar 'count'
				count <= count + 1'b1;
		end
		
		// Bloco always executado a cada mudanca de estado do 10 bit de "count"
		always @ ( count[9] )
		begin
				beep_r = !(count[13] & count[24] & count[27]);
		end
endmodule
