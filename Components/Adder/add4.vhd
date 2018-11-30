library ieee;
use ieee.std_logic_1164.all;

entity add4 is
port(
	x, y : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(4 downto 0)
);
end add4;

architecture behaviour of add4 is


component ha is
port(
	a, b : in std_logic;
	c, s : out std_logic
);
end component;


component fa is
port(
	a, b, cin : in std_logic;
	c, s : out std_logic
);
end component;


signal c : std_logic_vector(3 downto 0);


begin

c(0) <= '0'; -- first carry is 0 to perform the same function as a half adder

u0: fa port map(a => x(0), b => y(0), cin => c(0), c => c(1), s => s(0));
u1: fa port map(a => x(1), b => y(1), cin => c(1), c => c(2), s => s(1));
u2: fa port map(a => x(2), b => y(2), cin => c(2), c => c(3), s => s(2));
u3: fa port map(a => x(3), b => y(3), cin => c(3), c => s(4), s => s(3));


end behaviour;