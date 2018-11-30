library ieee;
use ieee.std_logic_1164.all;

entity SRFlipFlop is
port(
	CLK, S, R : in std_logic;
	Q, Qnot : out std_logic
);
end SRFlipFlop;

architecture structural of SRFlipFlop is

signal S_g, R_g, Qa, Qb : std_logic;
attribute keep : boolean;
attribute keep of S_g, R_g, Qa, Qb : signal is true;

begin

	S_g <= S nand CLK;
	R_g <= R nand CLK;
	Qa <= S_g nand Qb;
	Qb <= R_g nand Qa;
	Q <= Qa;
	Qnot <= Qb;

end structural;