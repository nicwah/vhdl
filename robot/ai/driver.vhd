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
           line_sensor : in std_logic_vector(2 downto 0);
           speed : out  std_logic_vector (2 downto 0);
           forward : out  std_logic;
           turn : out  std_logic_vector (2 downto 0);
           wait_time : out std_logic_vector (15 downto 0);
           enable_timer : out std_logic);
end driver;

architecture Behavioral of driver is

type states is (
    idle_state, 
    toggle_forward_backward_state, 
    drive_state, 
    turn_hard_right_state, 
    turn_right_state, 
    turn_ahead_state, 
    turn_left_state, 
    turn_hard_left_state, 
    stop_state);
signal state : states;

signal forward_i : std_logic := '0';

constant wait_1ms : std_logic_vector(15 downto 0) := "0000000000000001";
constant wait_1s : std_logic_vector(15 downto 0) := "0000001111101000";
constant wait_2s : std_logic_vector(15 downto 0) := "0000011111010000";
constant wait_4s : std_logic_vector(15 downto 0) := "0000111110100000";

constant speed_none : std_logic_vector(2 downto 0) := "000";
constant speed_normal : std_logic_vector(2 downto 0) := "001";

constant turn_hard_left  : std_logic_vector(2 downto 0) := "000";
constant turn_left       : std_logic_vector(2 downto 0) := "001";
constant turn_ahead      : std_logic_vector(2 downto 0) := "010";
constant turn_right      : std_logic_vector(2 downto 0) := "011";
constant turn_hard_right : std_logic_vector(2 downto 0) := "100";

constant veering_left     : std_logic_vector(2 downto 0) := "001";
constant drifting_left    : std_logic_vector(2 downto 0) := "011";
constant on_track         : std_logic_vector(2 downto 0) := "010";
constant drifting_right   : std_logic_vector(2 downto 0) := "110";
constant veering_right    : std_logic_vector(2 downto 0) := "100";
constant on_starting_line : std_logic_vector(2 downto 0) := "101";
constant on_finish_line   : std_logic_vector(2 downto 0) := "111";
constant off_track        : std_logic_vector(2 downto 0) := "000";

begin
    
    ChangeStatesStateMachine : process(alarm, line_sensor)
    begin
        if rising_edge(alarm) then
            case state is
                when idle_state =>
                    state <= toggle_forward_backward_state;
                when toggle_forward_backward_state =>
                    state <= drive_state;
                when stop_state =>
                    state <= toggle_forward_backward_state;
                when others => null;
            end case;
        end if;

        case state is
            when drive_state =>
                if not line_sensor /= off_track then
                    state <= stop_state;
                end if;
            when others => null;
        end case;
	end process;
	
    PerformActionsStateMachine : process(state)
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
            when turn_hard_right_state =>
                turn <= turn_hard_right;
                wait_time <= wait_1ms;
            when turn_right_state =>
                turn <= turn_right;
                wait_time <= wait_1ms;
            when turn_ahead_state =>
                turn <= turn_ahead;
                wait_time <= wait_1ms;
            when turn_left_state =>
                turn <= turn_left;
                wait_time <= wait_1ms;
            when turn_hard_left_state =>
                turn <= turn_hard_left;
                wait_time <= wait_1ms;
            when stop_state =>
                speed <= speed_none;	
                wait_time <= wait_1s;
            when others => null;
        end case;
        forward <= forward_i;
    end process;
    
end Behavioral;
