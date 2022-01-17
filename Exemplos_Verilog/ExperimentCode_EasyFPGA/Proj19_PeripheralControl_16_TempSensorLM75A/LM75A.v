/*
** LM75A.v
**
**
*/


module LM75A( input wire FPGA_CLK, input wire FPGA_RST, inout wire FPGA_SDA, output wire FPGA_SCL, output wire [3:0] DIG, output wire [7:0] SEG );  
		//wire clk = FPGA_CLK;
		//wire rst_n = FPGA_RST;
		//wire scl = FPGA_SCL;
		//wire sda = FPGA_SDA;
		//wire [3:0] cs = DIG;
		//wire [7:0] seg = SEG;
		wire done;
		wire [15:0] data;
		
		
		// Objeto do tipo 'I2C_READ':
		I2C_READ I2C_READ( .clk(FPGA_CLK), .rst_n(FPGA_RST), .scl(FPGA_SCL), .sda(FPGA_SDA), .data(data) );
		
		// Objeto do tipo 'SEG_D'
		SEG_D  SEG_D( .clk(FPGA_CLK), .rst_n(FPGA_RST), .cs(DIG), .seg(SEG), .data(data) );
endmodule
