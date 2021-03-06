library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_adder is
end testbench_adder;

architecture behaviour of testbench_adder is


component adder is
port(
	x, y : in std_logic_vector(1 downto 0);
	s : out std_logic_vector(2 downto 0)
);
end component;


signal x_in : std_logic_vector(1 downto 0);
signal y_in : std_logic_vector(1 downto 0);
signal s_out : std_logic_vector(2 downto 0);


begin

	uut: adder port map(
		x => x_in,
		y => y_in,
		s => s_out
	);


	stim_proc: process
	begin

		x_in <= "01";
		y_in <= "01";

		wait for 50ns;
		wait;

	end process;


end behaviour;