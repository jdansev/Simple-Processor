library ieee;
use ieee.std_logic_1164.all;

entity trin is
port(
	A : in std_logic_vector(1 downto 0);
	enable : in std_logic;
	Q : out std_logic_vector(1 downto 0)
);
end trin;

architecture behaviour of trin is

begin

	process (A, enable)
	begin
		if enable = '1' then
			Q <= A;
		else
			Q <= "ZZ";
		end if;
	end process;


end behaviour;