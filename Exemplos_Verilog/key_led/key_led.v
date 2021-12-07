
// Projeto: Utilização dos leds e botões do kit
//
// Autor: Diego Nagai (https://github.com/diegonagai)
//
// Data: 06/dez/2021

module key_led (key, led);

input [1:4] key;
output [1:4] led;

assign led = key;

endmodule
