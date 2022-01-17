/*
** ckey_led.v
**
**
*/

module ckey_led( input wire [3:0] KEY, output wire [3:0] LED );
	assign LED = KEY;
endmodule
