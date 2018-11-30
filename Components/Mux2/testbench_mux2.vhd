library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_mux2 is
end testbench_mux2;

architecture behaviour of testbench_mux2 is


component mux2 is
port(
	x, y, s : in std_logic;
	m : out std_logic
);
end component;


signal x : std_logic := '0';
signal y : std_logic := '0';
signal s : std_logic := '0';
signal m : std_logic;

signal count : integer := 0;

signal z : std_logic_vector(3 downto 0) := "0101";

begin

	uut: mux2 port map(
		x => x,
		y => y,
		s => s,
		m => m
	);
	
	stim_proc: process
	begin
	
		if (count = 10) then
		
			wait;
			
		else
		
			wait for 500ns;
			count <= count + 1;
			
		end if;
	
		
		
	end process;
	
	
	process(count)
		variable my_line : line;
	begin
	
		write(my_line, string'("Count: "));
		write(my_line, count);
		write(my_line, string'("\n"));
		
		writeline(output, my_line);
	
	end process;


end behaviour;







