# Controle de Periféricos - Projeto 6 - `sled`       
![Projeto em funcionamento](./Proj13_PeripheralControl_06_DigitalTubeStatisContrl.gif)       
       

## Código do projeto     
```verilog     
module sled( input wire FPGA_CLK, output reg [7:0] SEG, output reg [3:0] DIG );
		// Sinal para o clock
		wire clock = FPGA_CLK;
	
		// Variavel com os dados a serem exibidos no display de 7 segmentos
		reg [3:0] disp_dat;
	
		// Contador:
		reg [36:0] count;
	
		// --> Bloco always executado nas bordas de subida do clock:
		always @ (posedge clock )
		begin
			// Incrementar 'count'
			count = count + 1'b1;
			
			// Conteudo de 'DIG'
			DIG = 4'b0000;
		end
		
		// --> Bloco always executado quand o 25o bit de 'count' for 1
		always @ ( count[24] )
		begin
			disp_dat = { count[28:25] };
		end
		
		// --> Bloco 'always' executado a cada mudanca em 'disp_dat'
		always @ ( disp_dat )
		begin
				case (disp_dat)
						4'h0 : SEG = 8'b11000000;
						4'h1 : SEG = 8'b11111001;
						4'h2 : SEG = 8'b10100100; 
						4'h3 : SEG = 8'b10110000; 
						4'h4 : SEG = 8'b10011001;
						4'h5 : SEG = 8'b10010010;
						4'h6 : SEG = 8'b10000010;
						4'h7 : SEG = 8'b11111000;
						4'h8 : SEG = 8'b10000000;
						4'h9 : SEG = 8'b10010000;
						4'ha : SEG = 8'b10001000;
						4'hb : SEG = 8'b10000011;
						4'hc : SEG = 8'b11000110;
						4'hd : SEG = 8'b10100001;
						4'he : SEG = 8'b10000110;
						4'hf : SEG = 8'b10001110;
				endcase
		end
endmodule
```         
        
