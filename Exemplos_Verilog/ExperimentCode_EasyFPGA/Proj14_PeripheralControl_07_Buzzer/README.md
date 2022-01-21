# Controle de Periféricos - Projeto 7 - `beep`       


# Código do projeto     
        

## Código do módulo `beeep`     
```verilog     
module beep( input wire clk, output wire buzzer );
		// Variaveis: Contador e estado do buzzer
		reg beep_r;
		reg [27:0] count;
		
		// Bloco always, executado nas bordas de subida do clock, que inplementa 'count'
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
		
		// Atribuicao para o buzzer
		assign buzzer = beep_r;
endmodule
```         
        

## Código do módulo principal     
```verilog     
module demo_ep4ce6( input wire FPGA_CLK, output wire FPGA_BUZZER );
		beep meu_buzzer( .clk(FPGA_CLK), .buzzer(FPGA_BUZZER) );
endmodule
```         
        