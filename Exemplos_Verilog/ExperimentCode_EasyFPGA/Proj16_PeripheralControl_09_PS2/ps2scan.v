/*
** ps2scan.v
**
**
*/

`timescale 1ns / 1ps


module ps2scan( input wire clk, input wire rst_n, input wire ps2k_clk, input wire ps2k_data, output wire [7:0] ps2_byte, output wire ps2_state);
		//------------------------------------------
		reg ps2k_clk_r0, ps2k_clk_r1, ps2k_clk_r2;  //registrador de status ps2k_clk
		wire neg_ps2k_clk; //ps2k_clk flag para borda de descida
		
		
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if(!rst_n) begin
					ps2k_clk_r0 <= 1'b0;
					ps2k_clk_r1 <= 1'b0;
					ps2k_clk_r2 <= 1'b0;
				end
			
				else begin	// Estado de trava, filtro
					ps2k_clk_r0 <= ps2k_clk;
					ps2k_clk_r1 <= ps2k_clk_r0;
					ps2k_clk_r2 <= ps2k_clk_r1;
				end
		end
		
		// Atribuicao do estado de 'neg_ps2k_clk'
		assign neg_ps2k_clk = ~ps2k_clk_r1 & ps2k_clk_r2;	//Borda de descida
		
		
		//------------------------------------------
		reg [7:0] ps2_byte_r;		// PC recebe um byte de memória de dados do PS2
		reg [7:0] temp_data;			// registro de dados de recebimento atual
		reg [3:0] num;				   // registro de contagem
		
		
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if(!rst_n) begin
						num <= 4'd0;
						temp_data <= 8'd0;
				end
				
				// Detectada uma borda de descida em ps2k_clk
				else if( neg_ps2k_clk ) begin
						case( num )
								4'd0:	num <= num + 1'b1;
								
								4'd1:	begin
										num <= num + 1'b1;
										temp_data[0] <= ps2k_data;	//bit0
								end
								
								4'd2:	begin
									num <= num+1'b1;
									temp_data[1] <= ps2k_data;	//bit1
								end
								
								4'd3:	begin
									num <= num+1'b1;
									temp_data[2] <= ps2k_data;	//bit2
								end
								
								4'd4:	begin
									num <= num+1'b1;
									temp_data[3] <= ps2k_data;	//bit3
								end
								
								4'd5:	begin
									num <= num+1'b1;
									temp_data[4] <= ps2k_data;	//bit4
								end
				
								4'd6:	begin
									num <= num+1'b1;
									temp_data[5] <= ps2k_data;	//bit5
								end
								
								4'd7:	begin
									num <= num+1'b1;
									temp_data[6] <= ps2k_data;	//bit6
								end
								
								4'd8:	begin
									num <= num+1'b1;
									temp_data[7] <= ps2k_data;	//bit7
								end
				
								4'd9:	begin
									num <= num+1'b1;	//Bit de paridade, não processa
								end
								
								4'd10: begin
									num <= 4'd0;	// num é limpo
								end
				
								default: ;
						endcase
				end
		end
		
		
		//---------------
		reg key_f0;		// Solte o bit de sinalizador de chave, definido como 1 para indicar que os dados 8'hf0 são recebidos e, em seguida, apagado para 0 após receber os próximos dados
		reg ps2_state_r;	// O estado atual do teclado, ps2_state_r=1 significa que uma tecla foi pressionada
		
		
		// Processamento correspondente de dados recebidos, aqui apenas o valor da chave de 1 byte é processado
		always @ ( posedge clk or negedge rst_n ) 
		begin
				if( !rst_n ) begin
					key_f0 <= 1'b0;
					ps2_state_r <= 1'b0;
				end
				
				//Acabei de transferir um byte de dados
				else if( num == 4'd10 ) begin
						if( temp_data == 8'hf0 ) begin
								key_f0 <= 1'b1;
						end
						
						else begin
								// Indica que há uma tecla pressionada
								if( !key_f0 ) begin
										ps2_state_r <= 1'b1;
										ps2_byte_r <= temp_data; //Travar o valor da chave atual
								end
								
								else begin
										ps2_state_r <= 1'b0;
										key_f0 <= 1'b0;
								end
						end	
				end
		end
		
		// O código ASCII correspondente dos dados recebidos
		reg [7:0] ps2_asci;
		
		
		always @ ( ps2_byte_r ) begin
				// Converta o valor da chave para código ASCII, que é relativamente simples aqui, lidando apenas com letras
				case( ps2_byte_r )
						8'h15: ps2_asci <= 8'h51;	//Q
						8'h1d: ps2_asci <= 8'h57;	//W
						8'h24: ps2_asci <= 8'h45;	//E
						8'h2d: ps2_asci <= 8'h52;	//R
						8'h2c: ps2_asci <= 8'h54;	//T
						8'h35: ps2_asci <= 8'h59;	//Y
						8'h3c: ps2_asci <= 8'h55;	//U
						8'h43: ps2_asci <= 8'h49;	//I
						8'h44: ps2_asci <= 8'h4f;	//O
						8'h4d: ps2_asci <= 8'h50;	//P				  	
						8'h1c: ps2_asci <= 8'h41;	//A
						8'h1b: ps2_asci <= 8'h53;	//S
						8'h23: ps2_asci <= 8'h44;	//D
						8'h2b: ps2_asci <= 8'h46;	//F
						8'h34: ps2_asci <= 8'h47;	//G
						8'h33: ps2_asci <= 8'h48;	//H
						8'h3b: ps2_asci <= 8'h4a;	//J
						8'h42: ps2_asci <= 8'h4b;	//K
						8'h4b: ps2_asci <= 8'h4c;	//L
						8'h1a: ps2_asci <= 8'h5a;	//Z
						8'h22: ps2_asci <= 8'h58;	//X
						8'h21: ps2_asci <= 8'h43;	//C
						8'h2a: ps2_asci <= 8'h56;	//V
						8'h32: ps2_asci <= 8'h42;	//B
						8'h31: ps2_asci <= 8'h4e;	//N
						8'h3a: ps2_asci <= 8'h4d;	//M
						default: ;
				endcase
		end
		
		// --> Atribuicao dos sinais de 'ps2_byte' e 'ps2_state'
		assign ps2_byte = ps2_asci;	 
		assign ps2_state = ps2_state_r;
endmodule
