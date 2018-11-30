library ieee;
use ieee.std_logic_1164.all;

entity control_circuit is
port(
	f : in std_logic_vector(5 downto 0);
	clk : in std_logic;
	extern : in std_logic_vector(1 downto 0); -- 2bit external data
	
	-- debugging outputs
	output : out std_logic_vector(3 downto 0); -- state
	
	
	r0_data : out std_logic_vector(1 downto 0);
	r1_data : out std_logic_vector(1 downto 0);
	r2_data : out std_logic_vector(1 downto 0);
	r3_data : out std_logic_vector(1 downto 0);
	
	
	done : out std_logic
);
end control_circuit;

architecture behaviour of control_circuit is


-- 3bit register, actually 2 bit for now
component reg3 is
port(
	Rin : in std_logic;
	Din : in std_logic_vector(1 downto 0);
	Dout : out std_logic_vector(1 downto 0);
	clk : in std_logic

);
end component;



-- tri state vector
component trin is
port(
	A : in std_logic_vector(1 downto 0);
	enable : in std_logic;
	Q : out std_logic_vector(1 downto 0)
);
end component;


type State_Type is (IDLE, LOAD, MOVE, ADD1, ADD2, ADD3, SUB1, SUB2, SUB3);
signal state : State_Type := IDLE;


signal done_out : std_logic := '1';


signal inst, RX, RY : std_logic_vector(1 downto 0);


signal r_in : std_logic_vector(3 downto 0) := "0000";
signal r_out : std_logic_vector(3 downto 0) := "0000";


signal extern_data : std_logic_vector(1 downto 0);
signal extern_sig : std_logic := '0';


-- data connection between register 0 and its tri state buffer
signal r0_to_tsv : std_logic_vector(1 downto 0);
signal r1_to_tsv : std_logic_vector(1 downto 0);
signal r2_to_tsv : std_logic_vector(1 downto 0);
signal r3_to_tsv : std_logic_vector(1 downto 0);


-- defaults to an unknown signal
signal databus : std_logic_vector(1 downto 0) := "ZZ";


begin


-- registers
r0: reg3 port map(Rin => r_in(0), Din => databus, Dout => r0_to_tsv, clk => clk);
r1: reg3 port map(Rin => r_in(1), Din => databus, Dout => r1_to_tsv, clk => clk);
r2: reg3 port map(Rin => r_in(2), Din => databus, Dout => r2_to_tsv, clk => clk);
r3: reg3 port map(Rin => r_in(3), Din => databus, Dout => r3_to_tsv, clk => clk);


inst <= f(5 downto 4);
RX <= f(3 downto 2);
RY <= f(1 downto 0);
extern_data <= f(1 downto 0);



-- tri state vectors
r0_tsv: trin port map(A => r0_to_tsv, enable => r_out(0), Q => r0_data);
r1_tsv: trin port map(A => r1_to_tsv, enable => r_out(1), Q => r1_data);
r2_tsv: trin port map(A => r2_to_tsv, enable => r_out(2), Q => r2_data);
r3_tsv: trin port map(A => r3_to_tsv, enable => r_out(3), Q => r3_data);


extern_tsv: trin port map(A => extern_data, enable => extern_sig, Q => databus);





done <= done_out;

	
	clock_proc: process (clk)
	begin
	
		if rising_edge(clk) then
		
		
			if done_out = '1' then
			
				-- new instruction
				case inst is
					when "00" => -- load
						state <= LOAD;
						
						-- move external data into register
						
						extern_sig <= '1'; -- moves external data onto the databus
						
						
						case RX is
						
							when "00" =>
								r_in(0) <= '1';
								r_in(1) <= '0';
								r_in(2) <= '0';
								r_in(3) <= '0';
								r_out(0) <= '1';
								r_out(1) <= '0';
								r_out(2) <= '0';
								r_out(3) <= '0';
							
							when "01" =>
								r_in(0) <= '0';
								r_in(1) <= '1';
								r_in(2) <= '0';
								r_in(3) <= '0';
								r_out(0) <= '0';
								r_out(1) <= '1';
								r_out(2) <= '0';
								r_out(3) <= '0';
							
							when "10" =>
								r_in(0) <= '0';
								r_in(1) <= '0';
								r_in(2) <= '1';
								r_in(3) <= '0';
								r_out(0) <= '0';
								r_out(1) <= '0';
								r_out(2) <= '1';
								r_out(3) <= '0';

								
							when "11" =>
								r_in(0) <= '0';
								r_in(1) <= '0';
								r_in(2) <= '0';
								r_in(3) <= '1';
								r_out(0) <= '0';
								r_out(1) <= '0';
								r_out(2) <= '0';
								r_out(3) <= '1';
								
							when others =>
							
						end case;
						
						
						
						
					
					when "01" => -- move
						state <= MOVE;
					
					when "10" => -- add
						state <= ADD1;
					
					when "11" => -- sub
						state <= SUB1;
					
					when others => -- invalid instruction defaults to idle
						state <= IDLE;
					
				end case;
				
				-- not done for this clock cycle
				done_out <= '0';
				
			else
			
				-- move to the next state
				case state is
					when IDLE =>
					
						state <= IDLE;
						done_out <= '1';
						
					when LOAD =>
					
						
					
					
						state <= IDLE;
						
					when MOVE =>
						state <= IDLE;
						
					when ADD1 =>
						state <= ADD2;
						
					when ADD2 =>
						state <= ADD3;
						
					when ADD3 =>
						state <= IDLE;
						
					when SUB1 =>
						state <= SUB2;
						
					when SUB2 =>
						state <= SUB3;
						
					when SUB3 =>
						state <= IDLE;
						
					when others => state <= IDLE;
				end case;
			

			end if;
			
			
			
			
		end if;
		
	end process;
	
	
	
	-- process state output signals
	state_output_signals: process(state)
	begin
		case state is
			when IDLE => output <= "0000";
			when LOAD => output <= "0001";
			when MOVE => output <= "0010";
			when ADD1 => output <= "0011";
			when ADD2 => output <= "0100";
			when ADD3 => output <= "0101";
			when SUB1 => output <= "0110";
			when SUB2 => output <= "0111";
			when SUB3 => output <= "1000";
			when others => output <= "1111";
		end case;
		
		
	end process;

	

end behaviour;





