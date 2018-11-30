library ieee;
use ieee.std_logic_1164.all;

entity fa is
port(
	a, b, cin : in std_logic;
	c, s : out std_logic
);
end fa;

architecture behaviour of fa is

signal m : std_logic;

begin

	m <= a xor b;
	s <= m xor cin;
	c <=  (a and b) or (cin and a) or (cin and b);

end behaviour;