/*
** my_uart_tx.v
**
**
*/
`timescale 1ns / 1ps


module my_uart_tx(input clk, input rst_n, input [7:0] rx_data, input rx_int, input clk_bps, output rs232_tx, output bps_start);
		
		// Declaracao dos sinais e variaveis
		reg rx_int0, rx_int1, rx_int2;
		wire neg_rx_int;
		
		
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if( !rst_n ) begin
						rx_int0 <= 1'b0;
						rx_int1 <= 1'b0;
						rx_int2 <= 1'b0;
				end
				
				else begin
						rx_int0 <= rx_int;
						rx_int1 <= rx_int0;
						rx_int2 <= rx_int1;
				end
		end
		
		// Estado do sinal 'neg_rx_int'
		assign neg_rx_int =  ~rx_int1 & rx_int2;
		
		
		//---------------------------------------------------------
		reg[7:0] tx_data;	// Cadastrar para enviar dados
		//---------------------------------------------------------
		reg bps_start_r;
		reg tx_en;	//Enviar sinal de habilitacao de dados, ativo em HIGH
		reg[3:0] num;
		
		
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if( !rst_n ) begin
						bps_start_r <= 1'bz;
						tx_en <= 1'b0;
						tx_data <= 8'd0;
				end
				
				else if( neg_rx_int ) begin	//Depois de receber os dados, preparar para enviar os dados recebidos de volta
						bps_start_r <= 1'b1;
						tx_data <= rx_data;	// Armazenar os dados recebidos no registrador de dados de transmissao
						tx_en <= 1'b1;		// Entrando no estado de envio de dados
				end
				
				else if( num==4'd11 ) begin	//Transmissao de dados concluida
						bps_start_r <= 1'b0;
						tx_en <= 1'b0;
				end
		end
		
		// Estado de 'bps_start'
		assign bps_start = bps_start_r;
		
		
		//---------------------------------------------------------
		reg rs232_tx_r;
		
		always @ ( posedge clk or negedge rst_n )
		begin
				if(!rst_n) begin
						num <= 4'd0;
						rs232_tx_r <= 1'b1;
				end
		
		
				else if( tx_en ) begin
						if(clk_bps)	begin
								num <= num+1'b1;
						
								case (num)
										4'd0: rs232_tx_r <= 1'b0; 	//Enviar bit inicial
										4'd1: rs232_tx_r <= tx_data[0];	//Enviar bit0
										4'd2: rs232_tx_r <= tx_data[1];	//Enviar bit1
										4'd3: rs232_tx_r <= tx_data[2];	//Enviar bit2
										4'd4: rs232_tx_r <= tx_data[3];	//Enviar bit3
										4'd5: rs232_tx_r <= tx_data[4];	//Enviar bit4
										4'd6: rs232_tx_r <= tx_data[5];	//Enviar bit5
										4'd7: rs232_tx_r <= tx_data[6];	//Enviar bit6
										4'd8: rs232_tx_r <= tx_data[7];	//Enviar bit7
										4'd9: rs232_tx_r <= 1'b1;	// Enviar bit final
										default: rs232_tx_r <= 1'b1;
								endcase
						end
				end
				
				else if( num == 4'd11) begin
						num <= 4'd0;  // Redefinir
				end
		end
		
		// Atribuir o estado de 'rs232_tx'
		assign rs232_tx = rs232_tx_r;
endmodule
