library ieee;
use ieee.std_logic_1164.all;

entity reg3 is
port(
	Rin : in std_logic;
	Din : in std_logic_vector(1 downto 0);
	Dout : out std_logic_vector(1 downto 0);
	clk : in std_logic

);
end reg3;

architecture behaviour of reg3 is

signal data : std_logic_vector(1 downto 0) := "ZZ";

begin

Dout <= data;

	process(clk)
	begin

		if rising_edge(clk) then
		

			if Rin = '1' then
				data <= Din;
			end if;
			
		end if;

	end process;



end behaviour;