library IEEE;
use IEEE.std_logic_1164.all;


--Entidade
ENTITY Teste IS
    -- Pinos:
    port(
        FPGA_CLK : IN STD_LOGIC;
        LED : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END Teste;



-- Arquitetura
ARCHITECTURE programa_default OF Teste IS
		SIGNAL vals_led : STD_LOGIC_VECTOR(3 downto 0);
BEGIN
		
		proc_aguardar_1s : PROCESS( FPGA_CLK )
				CONSTANT PULSOS_1S : NATURAL := 50000000; -- Numero de pulsos referentes a 1s
				VARIABLE cont : NATURAL RANGE 0 TO PULSOS_1S := 0;
				VARIABLE n_led : INTEGER range 0 to 3 := 0;
		BEGIN
			IF( (FPGA_CLK 'EVENT) and (FPGA_CLK = '1') ) THEN
				-- incrementar 'cont'
				cont := cont + 1;
				
				-- Se 'cont' atingir ''
				IF( cont = PULSOS_1S ) THEN
					CASE n_led IS
						WHEN 0 => 
							n_led := 1;
							vals_led <= B"1110";
						WHEN 1 => 
							n_led := 2;
							vals_led <= B"1101";
						WHEN 2 => 
							n_led := 3;
							vals_led <= B"1011";
						WHEN 3 =>
							n_led := 0;
							vals_led <= B"0111";
						WHEN OTHERS =>
							n_led := 0;
							vals_led <= B"1110";
					END CASE;
				END IF;
			END IF;
		END PROCESS proc_aguardar_1s;
		
		LED <= vals_led;
END programa_default;