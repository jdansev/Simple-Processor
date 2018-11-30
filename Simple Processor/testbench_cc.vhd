library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_cc is
end testbench_cc;

architecture behaviour of testbench_cc is

component control_circuit is
port(
	f : in std_logic_vector(5 downto 0);
	clk : in std_logic;
	extern : in std_logic_vector(1 downto 0); -- 2bit external data
	
	output : out std_logic_vector(3 downto 0);
	
	r0_data : out std_logic_vector(1 downto 0);
	r1_data : out std_logic_vector(1 downto 0);
	r2_data : out std_logic_vector(1 downto 0);
	r3_data : out std_logic_vector(1 downto 0);
	
	done : out std_logic
	
);
end component;


signal f_in : std_logic_vector(5 downto 0);

signal clk_in : std_logic := '1';
signal done_out : std_logic := '0';

signal count : integer := 0;


signal extern_in : std_logic_vector(1 downto 0) := "10";


signal state_out : std_logic_vector(3 downto 0);



signal r0_out : std_logic_vector(1 downto 0);
signal r1_out : std_logic_vector(1 downto 0);
signal r2_out : std_logic_vector(1 downto 0);
signal r3_out : std_logic_vector(1 downto 0);

begin


	uut: control_circuit port map(
		f => f_in,
		clk => clk_in,
		output => state_out,
		
		r0_data => r0_out,
		r1_data => r1_out,
		r2_data => r2_out,
		r3_data => r3_out,
		
		extern => extern_in,
		done => done_out
	);


	stim_proc: process
	begin
		wait for 50ns;
		clk_in <= not clk_in;
	end process;
	
	
	count_proc: process (clk_in)
	begin
		if (rising_edge(clk_in)) then
			count <= count + 1;
		end if;
	end process;
	
	
	process
	begin
	
		wait for 400ns;
		f_in <= "001110"; -- load 10 into R3
		
		wait for 400ns;
		f_in <= "000011"; -- load 11 into R0
		wait;
	
	end process;
	
	
--	process (count)
--	begin
--	
--		case count is
--			when 0 =>
--			when 1 =>
--			when 2 => f_in <= "001110"; -- load 10 into R3
--			when 3 =>
--			when 4 =>
--			when 5 =>
--			when 6 => f_in <= "000011"; -- load 11 into R0
--			when 7 =>
--			when others =>
--		end case;
--		
--	end process;



end behaviour;