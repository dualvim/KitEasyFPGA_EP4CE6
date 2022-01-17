/*
** speed_select.v
**
**
*/

`timescale 1ns / 1ps


module speed_select(input wire clk, input wire rst_n, input wire bps_start, output wire clk_bps);
/*
parameter 		bps9600 	= 5207,	//Taxa de transmissao de 9600bps
			 	   bps19200 	= 2603,	//Taxa de transmissao de 19200bps
				   bps38400 	= 1301,	//Taxa de transmissao de 38400bps
				   bps57600 	= 867,	//Taxa de transmissao de 57600bps
				   bps115200	= 433;	//Taxa de transmissao de 115200bps

parameter 		bps9600_2 	= 2603,
				   bps19200_2	= 1301,
				   bps38400_2	= 650,
				   bps57600_2	= 433,
				   bps115200_2 = 216;  
*/

// Valores de cntagem de divisao de frequencia de taxa de transmissao
//			podem ser alterados de acordo com os valores acima
//
`define BPS_PARA		5207 
`define BPS_PARA_2	2603 


		// Declaracao de variaveis e sinais
		reg[12:0] cnt;
		reg clk_bps_r;
		
		// Registro de selecao da taxa de transmissao
		reg[2:0] uart_ctrl;
		
		// Bloco always executado nas bordas de subida de clk ou bordas de descida de rst
		always @ ( posedge clk or negedge rst_n )
		begin
				if( !rst_n ) begin
						cnt <= 13'd0;
				end
				
				else if( (cnt == `BPS_PARA) || !bps_start ) begin
						cnt <= 13'd0;
				end
				
				else begin
						cnt <= cnt + 1'b1;
				end
		end
		
		// Bloco always executado nas bordas de subida de clk ou bordas de descida de rst
		always @ ( posedge clk or negedge rst_n )
		begin
			if( !rst_n ) begin
					clk_bps_r <= 1'b0;
			end
			
			else if( (cnt == `BPS_PARA_2) && bps_start ) begin
					clk_bps_r <= 1'b1;
			end
			
			else begin
					clk_bps_r <= 1'b0;
			end
		end
		
		
		// --> Atribuir a 'clk_bps' o valor de 'clk_bps_r'
		assign clk_bps = clk_bps_r;
endmodule
 