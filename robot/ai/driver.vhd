----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:02 04/27/2018 
-- Design Name: 
-- Module Name:    driver - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity driver is
    Port ( alarm : in  std_logic;
           speed : out  std_logic_vector (2 downto 0);
           direction : out  std_logic;
			  wait_time : out std_logic_vector (15 downto 0);
			  enable_timer : out std_logic);
end driver;

architecture Behavioral of driver is

constant idle_state : std_logic_vector(3 downto 0) := "0000";
constant drive_forward_state : std_logic_vector(3 downto 0) := "0001";
constant stop1_state : std_logic_vector(3 downto 0) := "0010";
constant drive_backward_state : std_logic_vector(3 downto 0) := "0011";
constant stop2_state : std_logic_vector(3 downto 0) := "0100";

signal state : std_logic_vector(3 downto 0) := idle_state;

constant wait_1s : std_logic_vector(15 downto 0) := "0000001111101000";
constant wait_2s : std_logic_vector(15 downto 0) := "0000011111010000";
constant wait_4s : std_logic_vector(15 downto 0) := "0000111110100000";

begin
	ChangeStateMachine : process(alarm)
   begin
	if rising_edge(alarm) then
		case state is
            when idle_state =>
                state <= drive_forward_state;
            when drive_forward_state =>
                state <= stop1_state;
				when stop1_state =>
                state <= drive_backward_state;
				when drive_backward_state =>
                state <= stop2_state;
				when stop2_state =>
                state <= drive_forward_state;
				when others =>
                state <= idle_state;
		end case;
   end if;
	end process;
	
	BehaviourStateMachine : process(state)
   begin
	if rising_edge(state(0)) or rising_edge(state(1)) or rising_edge(state(2)) then
		case state is
            when idle_state =>
                speed <= "000";
					 direction <= '0';
					 wait_time <= wait_4s;
					 enable_timer <= '1';
            when drive_forward_state =>
                speed <= "001";
					 direction <= '1';
					 wait_time <= wait_2s;
					 enable_timer <= '1';
				when stop1_state =>
                speed <= "000";					
					 wait_time <= wait_1s;
					 enable_timer <= '1';
				when drive_backward_state =>
                speed <= "001";
					 direction <= '0';
					 wait_time <= wait_2s;
					 enable_timer <= '1';
				when stop2_state =>
                speed <= "000";
					 wait_time <= wait_1s;
					 enable_timer <= '1';
				when others =>
                speed <= "000";
					 direction <= '0';
					 enable_timer <= '0';
		end case;
   end if;
	end process;
	
end Behavioral;

