library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_add4 is
end testbench_add4;

architecture behaviour of testbench_add4 is

component add4 is
port(
	x, y : in std_logic_vector(3 downto 0);
	s : out std_logic_vector(4 downto 0)
);
end component;


signal x_in : std_logic_vector(3 downto 0);
signal y_in : std_logic_vector(3 downto 0);
signal s_out : std_logic_vector(4 downto 0);

begin

	uut: add4 port map(
		x => x_in,
		y => y_in,
		s => s_out
	);

	stim_proc: process
	begin
		
		x_in <= "1010";
		y_in <= "1101";
		
		wait for 50ns;
		wait;
	
	end process;


end behaviour;