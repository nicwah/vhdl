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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity driver is
    Port ( 
         mclk : in std_logic;
         line_sensor : in std_logic_vector(2 downto 0);
         speed : out std_logic_vector(2 downto 0);
         forward : out std_logic;
         turn : out std_logic_vector (2 downto 0)
         );
end driver;

architecture Behavioral of driver is

type states is (
    waiting_for_start_line_state,
    on_start_line_state,
    drive_straight_state, 
    turn_hard_right_state, 
    turn_right_state, 
    turn_left_state, 
    turn_hard_left_state, 
    stop_state,
    search_for_track_state);
    
signal state : states := waiting_for_start_line_state;

constant speed_none   : std_logic_vector(2 downto 0) := "000";
constant speed_slow   : std_logic_vector(2 downto 0) := "001";
constant speed_normal : std_logic_vector(2 downto 0) := "100";
constant speed_fast   : std_logic_vector(2 downto 0) := "111";

constant turn_ahead      : std_logic_vector(2 downto 0) := "000";
constant turn_hard_left  : std_logic_vector(2 downto 0) := "001";
constant turn_left       : std_logic_vector(2 downto 0) := "010";
constant turn_right      : std_logic_vector(2 downto 0) := "011";
constant turn_hard_right : std_logic_vector(2 downto 0) := "100";

constant veering_left   : std_logic_vector(2 downto 0) := "001";
constant drifting_left  : std_logic_vector(2 downto 0) := "011";
constant on_track       : std_logic_vector(2 downto 0) := "010";
constant drifting_right : std_logic_vector(2 downto 0) := "110";
constant veering_right  : std_logic_vector(2 downto 0) := "100";
constant on_start_line  : std_logic_vector(2 downto 0) := "101";
constant on_finish_line : std_logic_vector(2 downto 0) := "111";
constant off_track      : std_logic_vector(2 downto 0) := "000";

begin
    
    ChangeStatesStateMachine : process(mclk)
    begin
    if rising_edge(mclk) then
        case state is
            when waiting_for_start_line_state =>
                if line_sensor = on_start_line then
                    state <= drive_straight_state;
                end if;
            when stop_state =>
                state <= waiting_for_start_line_state;
            when search_for_track_state =>
                if line_sensor /= off_track then
                    state <= drive_straight_state;
                end if;
            when others =>
                case line_sensor is
                    when veering_left =>
                        state <= turn_hard_right_state;
                    when drifting_left =>
                        state <= turn_right_state;
                    when on_track =>
                        state <= drive_straight_state;
                    when drifting_right =>
                        state <= turn_left_state;
                    when veering_right =>
                        state <= turn_hard_left_state;
                    when on_finish_line =>
                        state <= stop_state;
                    when off_track =>
                        state <= search_for_track_state;
                    when others => null;
                end case;
        end case;
    end if;
	end process;
	
    PerformActionsStateMachine : process(state)
    begin
        case state is
            when waiting_for_start_line_state =>
                speed <= speed_none;
            when drive_straight_state =>
                speed <= speed_fast;
                forward <= '1';
                turn <= turn_ahead;
            when turn_hard_right_state =>
                speed <= speed_slow;
                turn <= turn_hard_right;
            when turn_right_state =>
                speed <= speed_normal;
                turn <= turn_right;
            when turn_left_state =>
                speed <= speed_normal;
                turn <= turn_left;
            when turn_hard_left_state =>
                speed <= speed_slow;
                turn <= turn_hard_left;
            when stop_state =>
                speed <= speed_none;
            when search_for_track_state =>
                speed <= speed_slow;
                turn <= turn_ahead;
            when others => null;
        end case;
    end process;
        
end Behavioral;
