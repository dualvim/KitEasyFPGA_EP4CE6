/*
** my_uart_top.v
**
**
*/

module my_uart_top( input wire FPGA_CLK, input wire FPGA_RST, input wire UART_RXD, output wire UART_TXD);
		// Sinais referentes aos nomes usados no projeto original
		wire clk = FPGA_CLK;
		wire rst_n = FPGA_RST;
		wire rs232_rx = UART_RXD;
		
		// Declaracao de sinais
		wire bps_start1, bps_start2;
		wire clk_bps1,clk_bps2;	
		wire[7:0] rx_data;
		wire rx_int; 

/*
** --> Entre os quatro módulos a seguir, speed_rx e speed_tx são dois módulos de hardware completamente independentes, que podem 
**				ser chamados de replicação lógica.
** --> (Não é compartilhamento de recursos e não pode ser confundido com a mesma chamada de subrotina no software)
*/

	// Objeto do modulo 'speed_select'; Módulo de seleção de taxa de transmissão
	speed_select speed_rx( .clk(clk), .rst_n(rst_n), .bps_start(bps_start1), .clk_bps(clk_bps1) );
	
	// Objeto do modulo 'my_uart_rx'; receber módulo de dados
	my_uart_rx my_uart_rx( .clk(clk), .rst_n(rst_n), .rs232_rx(rs232_rx), .rx_data(rx_data), .rx_int(rx_int), .clk_bps(clk_bps1), .bps_start(bps_start1) );
	
	///////////////////////////////////////////
	// Objeto do modulo 'speed_select'; Módulo de seleção de taxa de transmissão
	speed_select speed_tx( .clk(clk), .rst_n(rst_n), .bps_start(bps_start2), .clk_bps(clk_bps2) );
	
	// Objeto do modulo 'my_uart_tx'; receber módulo de dados
	my_uart_tx my_uart_tx(.clk(clk), .rst_n(rst_n), .rx_data(rx_data), .rx_int(rx_int), .rs232_tx(UART_TXD), .clk_bps(clk_bps2), .bps_start(bps_start2) );
endmodule
