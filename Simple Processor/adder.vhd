library ieee;
use ieee.std_logic_1164.all;

entity adder is
port(
	x, y : in std_logic_vector(1 downto 0);
	s : out std_logic_vector(2 downto 0)
);
end adder;

architecture behaviour of adder is


component fa is
port(
	a, b, cin : in std_logic;
	c, s : out std_logic
);
end component;


signal c : std_logic_vector(1 downto 0);


begin

c(0) <= '0'; -- first carry is 0 to perform the same function as a half adder

u0: fa port map(a => x(0), b => y(0), cin => c(0), c => c(1), s => s(0));
u1: fa port map(a => x(1), b => y(1), cin => c(1), c => s(2), s => s(1));


end behaviour;