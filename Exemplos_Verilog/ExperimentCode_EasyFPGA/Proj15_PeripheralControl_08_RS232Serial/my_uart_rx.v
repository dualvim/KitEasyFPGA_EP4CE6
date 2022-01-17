/*
** my_uart_rx.v
**
**
*/

`timescale 1ns / 1ps

module my_uart_rx( input clk, input rst_n, input rs232_rx, input clk_bps, output [7:0] rx_data, output reg rx_int, output bps_start );

		//----------------------------------------------------------------
		reg rs232_rx0, rs232_rx1, rs232_rx2, rs232_rx3; // Receber registro de dados para filtragem
		wire neg_rs232_rx;  // Indica que a linha de dados recebe uma borda de descida
	
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if(!rst_n) begin
						rs232_rx0 <= 1'b0;
						rs232_rx1 <= 1'b0;
						rs232_rx2 <= 1'b0;
						rs232_rx3 <= 1'b0;
				end
			
				else begin
						rs232_rx0 <= rs232_rx;
						rs232_rx1 <= rs232_rx0;
						rs232_rx2 <= rs232_rx1;
						rs232_rx3 <= rs232_rx2;
				end
		end
	
		// A detecção de borda descendente abaixo pode filtrar falhas <20ns-40ns (falhas de pulso alto e baixo),
		// Aqui é para trocar recursos por estabilidade (desde que não sejamos tão rigorosos com os requisitos de tempo, 
		//			porque o sinal de entrada foi batido algumas vezes)
		//(Eh claro que nosso sinal de pulso baixo efetivo deve ser muito maior que 40ns)
	
		// Neg_rs232_rx é definido como alto por um ciclo de clock após receber a borda descendente
		assign neg_rs232_rx = rs232_rx3 & rs232_rx2 & ~rs232_rx1 & ~rs232_rx0;

		
	
		//----------------------------------------------------------------
		reg bps_start_r;
		reg[3:0] num;	// Número de turnos
		//reg rx_int;		//Recebe sinal de interrupção de dados, sempre em alto nível durante a recepção de dados
		
		
		always @ ( posedge clk or negedge rst_n )
		begin
				if( !rst_n ) begin
						bps_start_r <= 1'bz;
						rx_int <= 1'b0;
				end
				
				else if( neg_rs232_rx ) begin // Recebeu o sinal de bandeira de borda descendente da linha de recepção da porta serial rs232_rx
						bps_start_r <= 1'b1;	// Inicie a porta serial para preparar a recepção de dados
						rx_int <= 1'b1;  // Ativar sinal de interrupção de dados
				end
				
				else if( num == 4'd11 ) begin //Informações de dados úteis recebidas
						bps_start_r <= 1'b0;  // Depois que os dados forem recebidos, solte o sinal de início da taxa de transmissão
						rx_int <= 1'b0;       // Receber sinal de interrupção de dados desligado
				end
		end
		
		// Atribuicao do estado de 'bps_start'
		assign bps_start = bps_start_r;
		
		
		//----------------------------------------------------------------
		reg[7:0] rx_data_r;		//A porta serial recebe o registro de dados e o salva até que os próximos dados cheguem
		//----------------------------------------------------------------
		reg[7:0] rx_temp_data;	//registro de dados de recebimento atual
		
		
		always @ ( posedge clk or negedge rst_n )
		begin
				if( !rst_n ) begin
						rx_temp_data <= 8'd0;
						num <= 4'd0;
						rx_data_r <= 8'd0;
				end
				
				else if(rx_int) begin	//receber processamento de dados
						if( clk_bps ) begin	//Leia e salve dados, receba dados como um bit inicial, dados de 8 bits, 1 ou 2 bits finais
								num <= num + 1'b1;
								
								case (num)
										4'd1: rx_temp_data[0] <= rs232_rx;	//Trave o bit 0
										4'd2: rx_temp_data[1] <= rs232_rx;	//Trave o bit 1
										4'd3: rx_temp_data[2] <= rs232_rx;	//Trave o bit 2
										4'd4: rx_temp_data[3] <= rs232_rx;	//Trave o bit 3
										4'd5: rx_temp_data[4] <= rs232_rx;	//Trave o bit 4
										4'd6: rx_temp_data[5] <= rs232_rx;	//Trave o bit 5
										4'd7: rx_temp_data[6] <= rs232_rx;	//Trave o bit 6
										4'd8: rx_temp_data[7] <= rs232_rx;	//Trave o bit 7
										default: ;
								endcase
						end
						
						// Nosso modo de recebimento padrão tem apenas 1+8+1(2)=11 bits de dados válidos
						// Altere o número após num neste lugar para 11. Acabou sendo 12! !
						else if(num == 4'd11) begin
								num <= 4'd0; // Terminar após receber o bit STOP, num é apagado
								rx_data_r <= rx_temp_data;	//Trave os dados no registro de dados rx_data
						end
				end
		end
		
		// Atribuir o estado de 'rx_data'
		assign rx_data = rx_data_r;	
endmodule
