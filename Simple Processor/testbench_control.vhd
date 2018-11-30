library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;

entity testbench_control is
end testbench_control;

architecture behaviour of testbench_control is


component control is
port(
	f : in std_logic_vector(5 downto 0);
	clk : in std_logic;
	
	done : out std_logic;
	
	state_out : out std_logic_vector(3 downto 0);
	
	r0_data : out std_logic_vector(1 downto 0);
	r1_data : out std_logic_vector(1 downto 0);
	r2_data : out std_logic_vector(1 downto 0);
	r3_data : out std_logic_vector(1 downto 0);
	
	rG_data : out std_logic_vector(1 downto 0);
	
	new_instruction : in std_logic
	
);
end component;


signal clk_in : std_logic := '0';
signal count : integer := 0;


signal code : std_logic_vector(5 downto 0) := "ZZZZZZ";
signal current_state : std_logic_vector(3 downto 0);
signal done_out : std_logic;

signal new_instruction : std_logic := '0';



signal r0_out : std_logic_vector(1 downto 0);
signal r1_out : std_logic_vector(1 downto 0);
signal r2_out : std_logic_vector(1 downto 0);
signal r3_out : std_logic_vector(1 downto 0);

signal rG_out : std_logic_vector(1 downto 0);


begin

	uut: control port map(
		f => code,
		clk => clk_in,
		done => done_out,
		state_out => current_state,
		
		r0_data => r0_out,
		r1_data => r1_out,
		r2_data => r2_out,
		r3_data => r3_out,
		
		rG_data => rG_out,
		
		new_instruction => new_instruction
	);


	clock_proc: process
	begin
		wait for 50ns;
		clk_in <= not clk_in;
	end process;
	
	count_proc: process (clk_in)
	begin
		if rising_edge(clk_in) then
			count <= count + 1;
		end if;
	end process;
	
	
	process (count)
	begin
	
		case count is
			-- reset
			when 0 to 4 =>
			
			-- load
			when 5 => code <= "001011"; new_instruction <= '1';
			when 6 to 9 => new_instruction <= '0';
			
			-- load
			when 10 => code <= "001110"; new_instruction <= '1';
			when 11 to 14 => new_instruction <= '0';
			
			-- move
			when 15 => code <= "010011"; new_instruction <= '1';
			when 16 to 19 => new_instruction <= '0';

			
			
			-- reset
			when others =>
		end case;
	
	end process;
	


end behaviour;







