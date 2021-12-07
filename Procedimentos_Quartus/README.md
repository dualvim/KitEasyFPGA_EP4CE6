# Procedimentos realizados no Quartus Prime:      
 - Essa pasta contém tutoriais mostrando como realizar algumas atividades importantes no Quartus Prime.       
 - Pastas e procedimentos explicados aqui:    
      - Pasta **`Novo_Proj_Quartus`**:    
            - Tutorial mostrando como criar um projeto para o kit EasyFPGA, usando o Quartus^©^ Prime Lite 20.1;    
	- Pasta **`Importar_Confs_Pinos`**:      
		- Tutorial mostrando como importar um arquivo `.csv` com as configurações dos pinos.        
	- Pasta **`Prog_Mem_Flash`**:      
		- Mostra como enviar o programa para a memória flash do kit FPGA.     
		- O procedimento padrão que envia o programa para o kit envia o programa para a memória SDRAM do kit. Logo, quando o kit é desligado é necessário reprogramá-lo.      
		- Enviando o programa compilado para a memória flash (CI **EPCS16**), basta enviar o programa para o kit apenas uma vez. O programa irá continuar disponível dentro do kit mesmo após ele ser desligado.      
		