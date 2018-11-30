library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_ha is
end testbench_ha;

architecture behaviour of testbench_ha is

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

signal a_in : std_logic;
signal b_in : std_logic;
signal c_in : std_logic;
signal c_out : std_logic;
signal s_out : std_logic;

begin

	uut: fa port map(
		a => a_in,
		b => b_in,
		cin => c_in,
		c => c_out,
		s => s_out
	);

	stim_proc: process
	begin
		
		a_in <= '0'; b_in <= '0'; c_in <= '1'; -- 0 1
		wait for 50ns;
		
		a_in <= '1'; b_in <= '1'; c_in <= '1'; -- 1 1
		wait for 50ns;
		
		a_in <= '1'; b_in <= '0'; c_in <= '1'; -- 1 0
		wait for 50ns;
	
		wait;

	end process;


end behaviour;