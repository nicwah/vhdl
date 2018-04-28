----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:34 04/27/2018 
-- Design Name: 
-- Module Name:    motor - Behavioral 
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

entity motor is
    Port ( speed : in  STD_LOGIC_VECTOR (2 downto 0);
           forward : in  STD_LOGIC;
           turn : in STD_LOGIC_VECTOR(2 downto 0);
           motor_ena : out  STD_LOGIC;
           motor_enb : out  STD_LOGIC;
           motor_in1 : out  STD_LOGIC;
           motor_in2 : out  STD_LOGIC;
           motor_in3 : out  STD_LOGIC;
           motor_in4 : out  STD_LOGIC);
end motor;

architecture Behavioral of motor is

begin
  
	motor_ena <= speed(0);
	motor_enb <= speed(0);
	motor_in1 <= forward;
	motor_in2 <= NOT(forward);
	motor_in4 <= forward;
	motor_in3 <= NOT(forward);
	
end Behavioral;

