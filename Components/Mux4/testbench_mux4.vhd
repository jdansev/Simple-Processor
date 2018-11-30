library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_mux4 is
end testbench_mux4;

architecture behaviour of testbench_mux4 is


component mux4 is
port(
	S : in std_logic;
	X, Y : in std_logic_vector(3 downto 0);
	M : out std_logic_vector(3 downto 0)
);
end component;


signal S : std_logic := '0';
signal X : std_logic_vector(3 downto 0) := "1100";
signal Y : std_logic_vector(3 downto 0) := "0011";
signal M : std_logic_vector(3 downto 0);


begin

	uut: mux4 port map(
		S => S,
		X => X,
		Y => Y,
		M => M
	);

	stim_proc: process
	begin

		s <= '0';
		wait for 50ns;

		s <= '1';
		wait for 50ns;

		wait;

	end process;


end behaviour;





