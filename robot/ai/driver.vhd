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
    Port ( alarm : in  STD_LOGIC;
           speed : out  STD_LOGIC_VECTOR (2 downto 0);
           direction : out  STD_LOGIC);
end driver;

architecture Behavioral of driver is


begin
	StateMachine : process(alarm)
   begin
	if rising_edge(alarm) then
		case state is
            when idle_state =>
                state <= drive_forward_state;
            when drive_forward_state =>
                state <= stop1_state;
		end case;
   end if;
	end process;
end Behavioral;

