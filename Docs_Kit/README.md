# Documentação do Kit RZ-EasyFpga A2.2      
 - Arquivos na pasta **`Configs_Pinos`**:      
	- **`Pinos_Kit_EasyFPGA.xlsx`**: Pasta de trabalho do Excel mostrando os pinos do kit FPGA e os respectivos dispositivos internos conectados ao CI FPGA.             
	- **`Pinos_EP4CE6E22C8.pdf`**: _Cheat sheet_ com o conteúdo da primeira planilha da pasta de trabalho.       
	- **`Pin_Planner_Completo.pdf`**: _Print_ da tela da ferramenta _Pin Planner_ do Quartus Prime, quando todos os pinos do kit FPGA estão configurados.      
	- **`Config_Pinos_Completa.csv`** e **`Config_Pinos_SemVGA.csv`**: Arquivo .csv com as configurações de todos os pinos do kit FPGA.          
		- No projeto do Quartus Prime, você pode mandar importar um desses arquivos na ferramenta _Pin Planner_ para importar rapidamente todas as configurações de pinos usadas no projeto.      
		- Em um teste que realizei aqui, a inclusão dos pinos da saída VGA no projeto gerou problemas durante a síntese.        
		- Caso não utilize a saída VGA do kit, use o arquivo `Config_Pinos_SemVGA.csv`.       
 - Arquivos na pasta **`Datasheets`**:              
	- Essa pasta contém os arquivos originais (EM INGLÊS) dos principais componentes do kit FPGA.       
	- **`Cyclone IV Datasheet.pdf`**     
	- **`Cyclone IV Handbook.pdf`**     
	- **`Cyclone IV pin connection design guide.pdf`**     
	- **`EP4CE6 pin information.pdf`**            
	- **`EPCS16.pdf`**: _Datasheet_ do CI com a memória de programas.     
	- **`HY57V641620FTP.pdf`**: _Datasheet_ do CI da SDRAM do kit.        
  - Arquivos na pasta **`EsquemaEletrico_e_Pinagem`**:                
	- **`Diagrama_Esquematico_RZ-EasyFPGA.pdf`**: Arquivo com o diagrama esquemático do kit FPGA, traduzido para o português.                 
	- **`Pinos_RZEasyFPGA.txt`**: Arquivo com as especificações dos pinos do kit. O conteúdo desse arquivo pode ser copiado e colado no arquivo `.qsf` do projeto do Quartus Prime.                
		
 