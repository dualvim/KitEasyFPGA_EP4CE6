# Lógica Digital - Projeto 6 - `half_adder`       
![Projeto em funcionamento](./Proj06_DigitalLogic_06_HalfAdder.gif)       
       

## Código do projeto     
```verilog     
module half_adder(input wire [3:0] KEY, output wire [1:0] LED);
		// Sinais referentes aos inputs
		wire A = ~KEY[0];
		wire B = ~KEY[1];
	
		// Sinais referentes aos LEDs
		wire S = A ^ B;   // Resultado da soma
		wire CO = A & B;   // Resultado do Carry-out
	
		// Acender/apagar os LEDs
		assign LED[0] = ~S;   // Resultado da soma
		assign LED[1] = ~CO; // Carry-out
endmodule
```         
        
