----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:55:20 05/01/2018 
-- Design Name: 
-- Module Name:    top_ai - Behavioral 
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

entity top_ai is
    Port ( mclk : in STD_LOGIC;
           btn : in std_logic_vector(3 downto 0); 
           sw : in std_logic_vector(7 downto 0);
           led : out std_logic_vector(7 downto 0);
           pio : inout std_logic_vector(87 downto 72));
end top_ai;

architecture Behavioral of top_ai is

alias linetracking : std_logic_vector(2 downto 0) is btn(2 downto 0);

signal speed : STD_LOGIC_VECTOR (2 downto 0);
signal forward : std_logic;
signal turn : std_logic_vector(2 downto 0);

component driver
    port(
        mclk: in std_logic;
        line_sensor: in std_logic_vector(2 downto 0);
        speed: out std_logic_vector(2 downto 0);
        forward: out std_logic;
        turn: out std_logic_vector(2 downto 0)
        );
end component;

begin

    led(0) <= forward;
    led(1) <= speed(0);
    led(2) <= speed(1);
    led(3) <= speed(2);
    led(4) <= turn(0);
    led(5) <= turn(1);
    led(6) <= turn(2);
    
    DriverInst : driver
        port map (
            mclk => mclk,
            line_sensor => linetracking,
            speed => speed,
            forward => forward,
            turn => turn
        );

end Behavioral;

