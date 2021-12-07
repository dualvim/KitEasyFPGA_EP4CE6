-- Kit Cyclone IV EasyFPGA 2.1
-- Demonstração de uma porta E (AND)
-- Como as entradas e saídas deste kit são acionadas com 0
-- usei sinais auxiliares para inverter as entradas e saídas.
-- Desta forma o comportamento visualizado bate com a função.
-- Prof. Filippo Valiante Filho - http://prof.valiante.info
-- https://github.com/filippovf/KitEasyFPGA


-- chamadas de bibliotecas
library ieee;
use ieee.std_logic_1164.all;

-- a entidade relaciona as entradas e saídas do sistema (ou bloco)
entity and_gate is
	port(
			A, B : in std_logic; -- pinos 138 e 143
			S : out std_logic    -- pino 141
	);
end and_gate;

-- a arquitetura descreve seu funcionamento
architecture Behavioral of and_gate is

-- área declarativa
	-- sinais auxiliares
	signal aa, bb, ss : std_logic;

begin

-- área de comandos
	-- inversão dos sinais de entrada e saída
	-- para que o comportamento observado na placa bata com o esperado
	aa <= not A;
	bb <= not B;
	S <= not ss; 	-- Lembre que os comandos são concorrentes (não há um "process")
					-- Assim essa saída não está antes da função abaixo...
					-- É uma descrição de hardware!
	-- função lógica propriamente dita:
	ss <= aa and bb;

end Behavioral;