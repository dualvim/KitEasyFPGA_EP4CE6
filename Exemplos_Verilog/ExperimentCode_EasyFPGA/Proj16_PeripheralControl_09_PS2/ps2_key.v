/*
** ps2_key.v
**
**
*/

/*
** --> O FPGA recebe os dados do teclado através do ps2 e, em seguida, converte os valores da letra A para Z recebidos no código ASCII 
**				correspondente e os envia para o PC através da porta serial.
** --> Durante o experimento, você precisa conectar o teclado e usar o assistente de depuração. 
** --> Depois de baixar o programa, pressione uma tecla no teclado, como A, você pode ver A no assistente de depuração do PC.
*/


module ps2_key(input wire FPGA_CLK, input wire FPGA_RST, input wire PS_CLOCK, input wire PS_DATA, output wire UART_TXD);
		// Sinais referentes aos nomes usados no projeto original
		wire clk = FPGA_CLK;
		wire rst_n = FPGA_RST;
		wire ps2k_clk = PS_CLOCK;
		wire ps2k_data = PS_DATA;
		
		// Declaracao de sinais e variaveis
		wire [7:0] ps2_byte;  // valor de chave de 1 byte
		wire ps2_state;      // sinalizador de status do botão
		wire bps_start;      // Depois que os dados são recebidos, o sinal de início do clock da taxa de transmissão é ativado
		wire clk_bps;        // O alto nível de clk_bps é o ponto de amostragem médio de recebimento ou envio de bits de dados
		
		
		// --> Objeto do modulo 'ps2scan'; Módulo de digitalização de chaves
		ps2scan ps2scan( .clk(clk), .rst_n(rst_n), .ps2k_clk(ps2k_clk), .ps2k_data(ps2k_data), .ps2_byte(ps2_byte), .ps2_state(ps2_state) );
		
		// --> Objeto do modulo 'speed_select'; 
		speed_select speed_select( .clk(clk), .rst_n(rst_n), .bps_start(bps_start), .clk_bps(clk_bps) );	
		
		// --> Objeto do modulo 'my_uart_tx';
		my_uart_tx my_uart_tx( .clk(clk), .rst_n(rst_n), .clk_bps(clk_bps), .rx_data(ps2_byte), .rx_int(ps2_state), .rs232_tx(UART_TXD), .bps_start(bps_start));
endmodule
