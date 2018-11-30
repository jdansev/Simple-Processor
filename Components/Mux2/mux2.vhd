library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
port(
	x, y, s : in std_logic;
	m : out std_logic
);
end mux2;


architecture behaviour of mux2 is


begin

	process(x,y,s)
	begin
	
		case s is
			when '0' => m <= x;
			when '1' => m <= y;
			when others => m <= '0';
		end case;
		
	end process;

end behaviour;