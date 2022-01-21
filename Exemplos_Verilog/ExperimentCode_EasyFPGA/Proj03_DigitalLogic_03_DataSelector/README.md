# Lógica Digital - Projeto 3 - `my_mux`       
![Projeto em funcionamento](./Proj03_DigitalLogic_03_DataSelector.gif)       
       

# Código do projeto   
         

## Módulo `mux_2_1`   
```verilog     
module mux_2_1( input wire sel, A, B, output wire L );
		// Selecionar o input
		assign L = sel ? B : A;
endmodule
```         
        


## Módulo principal     
```verilog
module demo_ep4ce6( input wire [3:0] KEY, output wire [0:0] LED );
		mux_2_1 my_mux( .sel(KEY[2]), .A(KEY[0]), .B(KEY[1]), .L(LED[0]) );
endmodule
```      
         