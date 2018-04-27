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
           forward : out  std_logic;
           turn : out  std_logic_vector (2 downto 0);
           wait_time : out std_logic_vector (15 downto 0);
           enable_timer : out std_logic);
end driver;

architecture Behavioral of driver is

constant idle_state : std_logic_vector(3 downto 0) := "0000";
constant toggle_forward_backward_state : std_logic_vector(3 downto 0) := "0001";
constant drive_state : std_logic_vector(3 downto 0) := "0010";
constant turn_right_state : std_logic_vector(3 downto 0) := "0011";
constant turn_left_state : std_logic_vector(3 downto 0) := "0100";
constant turn_ahead_state : std_logic_vector(3 downto 0) := "0101";
constant stop_state : std_logic_vector(3 downto 0) := "0110";

signal state : std_logic_vector(3 downto 0) := idle_state;
signal forward_i : std_logic := '0';

constant wait_1ms : std_logic_vector(15 downto 0) := "0000000000000001";
constant wait_1s : std_logic_vector(15 downto 0) := "0000001111101000";
constant wait_2s : std_logic_vector(15 downto 0) := "0000011111010000";
constant wait_4s : std_logic_vector(15 downto 0) := "0000111110100000";

constant speed_none : std_logic_vector(2 downto 0) := "000";
constant speed_normal : std_logic_vector(2 downto 0) := "001";

constant turn_hard_left  : std_logic_vector(2 downto 0) := "000";
constant turn_left       : std_logic_vector(2 downto 0) := "001";
constant turn_ahead       : std_logic_vector(2 downto 0) := "010";
constant turn_right      : std_logic_vector(2 downto 0) := "011";
constant turn_hard_right : std_logic_vector(2 downto 0) := "100";

begin
    ChangeStateMachine : process(alarm)
    begin
    if rising_edge(alarm) then
        case state is
            when idle_state =>
                state <= toggle_forward_backward_state;
            when toggle_forward_backward_state =>
                state <= drive_state;
            when drive_state =>
                state <= turn_right_state;
            when turn_right_state =>
                state <= turn_left_state;
            when turn_left_state =>
                state <= turn_ahead_state;
            when turn_ahead_state =>
                state <= stop_state;
            when stop_state =>
                state <= toggle_forward_backward_state;
            when others =>
                state <= idle_state;
        end case;
    end if;
	end process;
	
    BehaviourStateMachine : process(state)
    begin
        case state is
            when idle_state =>
                speed <= speed_none;
                turn <= turn_ahead;
                forward_i <= '0';
                wait_time <= wait_4s;
                enable_timer <= '1';
            when toggle_forward_backward_state =>
                forward_i <= not forward_i;
                wait_time <= wait_1ms;
            when drive_state =>
                speed <= speed_normal;
                wait_time <= wait_2s;
            when turn_right_state =>
                turn <= turn_right;
                wait_time <= wait_2s;
            when turn_left_state =>
                turn <= turn_left;
                wait_time <= wait_1s;
            when turn_ahead_state =>
                turn <= turn_ahead;
                wait_time <= wait_1s;
            when stop_state =>
                speed <= speed_none;	
                wait_time <= wait_1s;
            when others =>
                speed <= speed_none;
                forward_i <= '0';
                turn <= turn_ahead;
                enable_timer <= '0';
        end case;
        forward <= forward_i;
    end process;
    
end Behavioral;
