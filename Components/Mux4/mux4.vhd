library ieee;
use ieee.std_logic_1164.all;



entity mux4 is
port(
	S : in std_logic;
	X, Y : in std_logic_vector(3 downto 0);
	M : out std_logic_vector(3 downto 0)
);
end mux4;



architecture behaviour of mux4 is

begin

	process(S,X,Y)
	begin
		case S is
			when '0' => M <= X;
			when '1' => M <= Y;
			when others => M <= "0000";
		end case;
	end process;

end behaviour;