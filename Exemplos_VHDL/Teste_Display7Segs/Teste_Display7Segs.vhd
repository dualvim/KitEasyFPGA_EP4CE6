-- Teste_Display7Segs.vhd
--
-- Sobre esse projeto:
-- # Objetivo: Usar o display de 7 segmentos de 4 digitos da placa FPGA
-- 		--> Isto eh, cria um contador de 0 a 9999
--			--> A cada 1 segundo o contador eh incrementado em 1.
--			--> Os digitos do display sao atualizados a cada 1ms
--


library IEEE;
use IEEE.std_logic_1164.all;


--Entidade
ENTITY Teste_Display7Segs IS
    -- Pinos:
    port(
        FPGA_CLK : IN STD_LOGIC;
        SEG : OUT STD_LOGIC_VECTOR(7 downto 0);
		  DIG : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END Teste_Display7Segs;


-- Arquitetura
ARCHITECTURE arq OF Teste_Display7Segs IS
		--
		-- Procedimento para retornar os estados de cada um dos segmentos do display
		PROCEDURE retornar_sinal_segmentos(VARIABLE n : IN NATURAL RANGE 0 TO 9;
														SIGNAL arr_segs : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) 
														) IS
		-- Inicio do procedimento
		BEGIN
				-- Sinal referente ao numero
				CASE( n ) is
					WHEN 0 => 
						arr_segs <= B"1100_0000";
					WHEN 1 => 
						arr_segs <= B"1111_1001";
					WHEN 2 => 
						arr_segs <= B"1010_0100";
					WHEN 3 => 
						arr_segs <= B"1011_0000";
					WHEN 4 => 
						arr_segs <= B"1001_1001";
					WHEN 5 => 
						arr_segs <= B"1001_0010";
					WHEN 6 => 
						arr_segs <= B"1000_0010";
					WHEN 7 => 
						arr_segs <= B"1111_1000";
					WHEN 8 => 
						arr_segs <= B"1000_0000";
					WHEN 9 => 
						arr_segs <= B"1001_1000";
					WHEN OTHERS =>
						arr_segs <= B"1100_0000";
				END CASE;
		
		END retornar_sinal_segmentos;
		
		
		SIGNAL segs_dsp : STD_LOGIC_VECTOR(7 downto 0);
		--SIGNAL digs_dsp : STD_LOGIC_VECTOR(1 downto 0);
BEGIN
		
		proc_aguardar_1s : PROCESS( FPGA_CLK )
				CONSTANT PULSOS_1S : NATURAL := 50000000; -- Numero de pulsos referentes a 1s
				CONSTANT PULSOS_001S : NATURAL := 50000; -- Numero de pulsos referentes a 0.001s
				CONSTANT PULSOS_002S : NATURAL := 100000; -- Numero de pulsos referentes a 0.002s
				CONSTANT PULSOS_003S : NATURAL := 150000; -- Numero de pulsos referentes a 0.003s
				CONSTANT PULSOS_004S : NATURAL := 200000; -- Numero de pulsos referentes a 0.004s
				
				VARIABLE c_pulsos : NATURAL RANGE 0 TO PULSOS_1S := 0;
				VARIABLE c_pulsos2 : NATURAL RANGE 0 TO PULSOS_004S := 0;
				VARIABLE contador : NATURAL RANGE 0 TO 9999 := 0;
				VARIABLE unidade : NATURAL RANGE 0 TO 9 := 0;
				VARIABLE dezena : NATURAL RANGE 0 TO 9 := 0;
				VARIABLE centena : NATURAL RANGE 0 TO 9 := 0;
				VARIABLE milhar : NATURAL RANGE 0 TO 9 := 0;
		BEGIN
		
			-- Calcular os valores dos quatro digitos do display
			milhar := contador / 1000;
			centena := (contador rem 1000) / 100;
			dezena := (contador rem 100) / 10;
			unidade := contador rem 10;
			
			
			-- Evento: Borda de subida de um pulso de clock
			IF( (FPGA_CLK 'EVENT) and (FPGA_CLK = '1') ) THEN
				-- incrementar 'c_pulsos' e 'c_pulsos2'
				c_pulsos := c_pulsos + 1;
				c_pulsos2 := c_pulsos2 + 1;
				
				-- Se 'c_pulsos2' for igual a 'PULSOS_01S'
				IF( c_pulsos2 = PULSOS_001S ) THEN
						retornar_sinal_segmentos(unidade, segs_dsp);
						--digs_dsp <= "10";
						DIG <= "1110";
				
				-- Se 'c_pulsos2' for igual a 'PULSOS_01S'
				ELSIF( c_pulsos2 = PULSOS_002S ) THEN
						retornar_sinal_segmentos(dezena, segs_dsp);
						--digs_dsp <= "01";
						DIG <= "1101";
				
				-- Se 'c_pulsos2' for igual a 'PULSOS_003S'
				ELSIF( c_pulsos2 = PULSOS_003S ) THEN
						retornar_sinal_segmentos(centena, segs_dsp);
						DIG <= "1011";
				
				-- Se 'c_pulsos2' for igual a 'PULSOS_004S'
				ELSIF( c_pulsos2 = PULSOS_004S ) THEN
						retornar_sinal_segmentos(milhar, segs_dsp);
						DIG <= "0111";
						-- Zerar 'c_pulsos2'
						c_pulsos2 := 0;
				END IF;
				
				
				
				-- Se 'c_pulsos' for igual a 'PULSOS_1S'
				IF( c_pulsos = PULSOS_1S ) THEN
						-- Incrementar 'contador'
						contador := contador + 1;
						-- Zerar 'c_pulsos'
						c_pulsos := 0;
				END IF;
			END IF;
		END PROCESS proc_aguardar_1s;
		
		-- Atribuir os sinais
		SEG <= segs_dsp;
		--DIG <= digs_dsp;
END arq;
