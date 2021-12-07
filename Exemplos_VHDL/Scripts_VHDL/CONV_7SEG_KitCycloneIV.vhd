-- Kit Cyclone IV RZ EasyFPGA
-- Demonstração do display de 7 segmentos. Acionamento através das switches (ou botões).
-- Prof. Filippo Valiante Filho - http://prof.valiante.info
-- https://github.com/filippovf/KitEasyFPGA

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONV_7SEG is
    Port ( 	dig1, dig2, dig3, dig4 : out std_logic; -- pinos 133, 135, 136, 137
			ENT : in  STD_LOGIC_VECTOR (0 to 3); -- pinos 88 a 91 * chaves numeradas da esq p/ dir neste kit!
			SEG : out  STD_LOGIC_VECTOR (6 downto 0)); -- pinos 124, 126, 132, 129, 125, 121, 128
end CONV_7SEG;

architecture Behavioral of CONV_7SEG is

	signal entrada_corrigida : std_LOGIC_VECTOR(0 to 3);

begin
	dig1 <= '0'; -- o enable do display é feito com "0"
	dig2 <= '0';
	dig3 <= '0';
	dig4 <= '0';
	
	entrada_corrigida <= not ENT; -- Entradas invertidas para ficar visualmente certo no kit.
	-- As chaves são numeradas da esquerda para a direita! 1 a 4, por isso foram declarados como (0 to 3)
	-- Os displays de 7 segmentos estão numerados como esperado... (6 downto 0)
	--      0
	--     ---  
	--  5 |   | 1
	--     ---   <- 6
	--  4 |   | 2
	--     ---
	--      3
	
   with entrada_corrigida select
   SEG<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0

end Behavioral;






