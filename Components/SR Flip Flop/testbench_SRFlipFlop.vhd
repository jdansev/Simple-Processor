library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_SRFlipFlop is
end testbench_SRFlipFlop;

architecture behaviour of testbench_SRFlipFlop is

component SRFlipFlop is
port(
	CLK, S, R : in std_logic;
	Q, Qnot : out std_logic
);
end component;

signal count : integer := 0;

signal clk_in, S_in, R_in, Q_out, Q_not : std_logic;



begin


	uut: SRFlipFlop port map(
		CLK => clk_in,
		R => R_in,
		S => S_in,
		Q => Q_out,
		Qnot => q_not
	);

	stim_proc: process
	begin
		if count = 20 then
			wait;
		else
			wait for 50ns;
			count <= count + 1;
		end if;
	end process;
	
	process (count)
	begin
		case count is
			when 0 =>
			when 1 =>
				clk_in <= '1'; S_in <= '1'; R_in <= '0'; -- set
			when 2 =>
			when 3 =>
			when 4 =>
				clk_in <= '1'; S_in <= '0'; R_in <= '0'; -- memory
			when 5 =>
			when 6 =>
			when 7 =>
				clk_in <= '1'; S_in <= '0'; R_in <= '1'; -- reset
			when 8 =>
			when 9 =>
			when 10 =>
				clk_in <= '1'; S_in <= '1'; R_in <= '0'; -- set
			when others =>
		end case;
	end process;



end behaviour;