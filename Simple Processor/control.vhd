library ieee;
use ieee.std_logic_1164.all;

entity control is
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
end control;

architecture behaviour of control is


component reg3 is
port(
	Rin : in std_logic;
	Din : in std_logic_vector(1 downto 0);
	Dout : out std_logic_vector(1 downto 0);
	clk : in std_logic
);
end component;

component trin is
port(
	A : in std_logic_vector(1 downto 0);
	enable : in std_logic;
	Q : out std_logic_vector(1 downto 0)
);
end component;

component adder is
port(
	x, y : in std_logic_vector(1 downto 0);
	s : out std_logic_vector(2 downto 0)
);
end component;


type State_Type is (IDLE, LOAD, MOVE, ADD1, ADD2, ADD3, SUB1, SUB2, SUB3);
signal state : State_Type := IDLE;

signal inst, RX, RY : std_logic_vector(1 downto 0);

signal done_out : std_logic := '1';


signal AddSub : std_logic := '0';


signal r_in, r_out : std_logic_vector(3 downto 0) := "0000";
signal a_in, g_in, g_out : std_logic := '0';


signal extern_data : std_logic_vector(1 downto 0);
signal extern_sig : std_logic := '0';


signal databus : std_logic_vector(1 downto 0);



signal next_state : State_Type;



-- data connection between registers and tri state buffers
signal r0_to_tsv : std_logic_vector(1 downto 0);
signal r1_to_tsv : std_logic_vector(1 downto 0);
signal r2_to_tsv : std_logic_vector(1 downto 0);
signal r3_to_tsv : std_logic_vector(1 downto 0);


signal rA_to_ALU : std_logic_vector(1 downto 0);
signal ALU_to_rG : std_logic_vector(2 downto 0);
signal rG_to_tsv : std_logic_vector(1 downto 0);


signal r0_temp : std_logic_vector(1 downto 0);
signal r1_temp : std_logic_vector(1 downto 0);
signal r2_temp : std_logic_vector(1 downto 0);
signal r3_temp : std_logic_vector(1 downto 0);


begin

inst <= f(5 downto 4);
RX <= f(3 downto 2);
RY <= f(1 downto 0);
extern_data <= f(1 downto 0);


-- registers
r0: reg3 port map(Rin => r_in(0), Din => databus, Dout => r0_to_tsv, clk => clk);
r1: reg3 port map(Rin => r_in(1), Din => databus, Dout => r1_to_tsv, clk => clk);
r2: reg3 port map(Rin => r_in(2), Din => databus, Dout => r2_to_tsv, clk => clk);
r3: reg3 port map(Rin => r_in(3), Din => databus, Dout => r3_to_tsv, clk => clk);

-- ALU registers

rA: reg3 port map(Rin => a_in, Din => databus, Dout => rA_to_ALU, clk => clk);
rG: reg3 port map(Rin => g_in, Din => databus, Dout => rG_to_tsv, clk => clk);


-- ALU
alu: adder port map(x => rA_to_ALU, y => databus, s => ALU_to_rG);


-- tri state vectors
r0_tsv: trin port map(A => r0_to_tsv, enable => r_out(0), Q => r0_data);
r1_tsv: trin port map(A => r1_to_tsv, enable => r_out(1), Q => r1_data);
r2_tsv: trin port map(A => r2_to_tsv, enable => r_out(2), Q => r2_data);
r3_tsv: trin port map(A => r3_to_tsv, enable => r_out(3), Q => r3_data);
-- extern
extern_tsv: trin port map(A => extern_data, enable => extern_sig, Q => databus);


-- other
rG_tsv: trin port map(A => rG_to_tsv, enable => g_out, Q => rG_data);


	process (clk)
	begin
		if rising_edge(clk) then
		
			
		
			
				-- move to the next state
				case state is
				
					when IDLE =>
					
					
						if new_instruction = '1' then
					
					
							if inst = "00" then -- load
							
								extern_sig <= '1';
								
								case RX is
								
									-- R0
									when "00" =>
										r_in(0) <= '1';
										r_in(1) <= '0';
										r_in(2) <= '0';
										r_in(3) <= '0';
										r_out(0) <= '1';
										r_out(1) <= '0';
										r_out(2) <= '0';
										r_out(3) <= '0';
										
									-- R1
									when "01" =>
										r_in(0) <= '0';
										r_in(1) <= '1';
										r_in(2) <= '0';
										r_in(3) <= '0';
										r_out(0) <= '0';
										r_out(1) <= '1';
										r_out(2) <= '0';
										r_out(3) <= '0';
										
									-- R2
									when "10" =>
										r_in(0) <= '0';
										r_in(1) <= '0';
										r_in(2) <= '1';
										r_in(3) <= '0';
										r_out(0) <= '0';
										r_out(1) <= '0';
										r_out(2) <= '1';
										r_out(3) <= '0';
										
									-- R3
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
					
								
							
								next_state <= LOAD;
								
							elsif inst = "01" then -- mov
							
								extern_sig <= '0';
							
								r_in(0) <= '0';
								r_in(1) <= '0';
								r_in(2) <= '0';
								r_in(3) <= '0';
								r_out(0) <= '0';
								r_out(1) <= '0';
								r_out(2) <= '0';
								r_out(3) <= '0';
								
								case RX is
									when "00" => r_in(0) <= '1';
									when "01" => r_in(1) <= '1';
									when "10" => r_in(2) <= '1';
									when "11" => r_in(3) <= '1';
									when others =>
								end case;
								
								case RY is
									when "00" => r_out(0) <= '1';
									when "01" => r_out(1) <= '1';
									when "10" => r_out(2) <= '1';
									when "11" => r_out(3) <= '1';
									when others =>
								end case;
							
							
								next_state <= MOVE;
								
							elsif inst = "10" then -- add
							
								extern_sig <= '0';
							
							
								r_in(0) <= '0';
								r_in(1) <= '0';
								r_in(2) <= '0';
								r_in(3) <= '0';
								r_out(0) <= '0';
								r_out(1) <= '0';
								r_out(2) <= '0';
								r_out(3) <= '0';
								
								
								case RX is
									when "00" => r_out(0) <= '1';
									when "01" => r_out(1) <= '1';
									when "10" => r_out(2) <= '1';
									when "11" => r_out(3) <= '1';
									when others =>
								end case;
							
								next_state <= ADD1;
								
								
							elsif inst = "11" then -- sub
								next_state <= SUB1;
								
							end if;
							
							
						end if;
						
						
					when LOAD =>
					
						
					
						next_state <= IDLE;
						
					when MOVE =>
						next_state <= IDLE;
						
					when ADD1 =>
					
						
					
					
						next_state <= ADD2;
						
					when ADD2 =>
						next_state <= ADD3;
						
					when ADD3 =>
						next_state <= IDLE;
						
					when SUB1 =>
						next_state <= SUB2;
						
					when SUB2 =>
						next_state <= SUB3;
						
					when SUB3 =>
						next_state <= IDLE;
						
					when others =>
						next_state <= IDLE;
				end case;
				

		
		end if;
	end process;
	
	
	process (next_state)
	begin
	
		state <= next_state;
		
	end process;


	process (state)
	begin

		case state is
			when IDLE => state_out <= "0000";
			when LOAD => state_out <= "0001";
			when MOVE => state_out <= "0010";
			when ADD1 => state_out <= "0011";
			when ADD2 => state_out <= "0100";
			when ADD3 => state_out <= "0101";
			when SUB1 => state_out <= "0110";
			when SUB2 => state_out <= "0111";
			when SUB3 => state_out <= "1000";
			when others => state_out <= "1111";
		end case;
		
		done <= done_out;

	end process;



end behaviour;