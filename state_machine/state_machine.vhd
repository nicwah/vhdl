----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:30 04/18/2018 
-- Design Name: 
-- Module Name:    state_machine - Behavioral 
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

entity state_machine is
    Port ( btn : in  STD_LOGIC_VECTOR (3 downto 0);
           led : out  STD_LOGIC_VECTOR (3 downto 0);
           mclk : in  STD_LOGIC);
end state_machine;

architecture Behavioral of state_machine is

constant idle_state : std_logic_vector(3 downto 0) := "0000";
constant led1_state : std_logic_vector(3 downto 0) := "0001";
constant led2_state : std_logic_vector(3 downto 0) := "0010";
constant led3_state : std_logic_vector(3 downto 0) := "0100";

signal state : std_logic_vector(3 downto 0) := idle_state;

begin

    led(3 downto 0) <= state(3 downto 0);

    StateMachine : process(mclk)
    begin
    if rising_edge(mclk) then
        case state is
            when idle_state =>
                if btn(0) = '1' then
                    state <= led1_state;
                end if;
            when led1_state =>
                if btn(1) = '1' then
                    state <= led2_state;
                end if;
            when led2_state =>
                if btn(2) = '1' then
                    state <= led3_state;
                end if;
            when led3_state =>
                if btn(3) = '1' then
                    state <= idle_state;
                end if;
            when others =>
                state <= idle_state;
         end case;
     end if;
     end process;
end Behavioral;

