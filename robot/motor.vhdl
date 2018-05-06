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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity motor is
    Port ( speed : in  STD_LOGIC_VECTOR (2 downto 0);
           forward : in  STD_LOGIC;
           turn : in STD_LOGIC_VECTOR(2 downto 0);
           motor_ena : out  STD_LOGIC := '0';
           motor_enb : out  STD_LOGIC := '0';
           motor_in1 : out  STD_LOGIC;
           motor_in2 : out  STD_LOGIC;
           motor_in3 : out  STD_LOGIC;
           motor_in4 : out  STD_LOGIC;
           wait_time_1 : out std_logic_vector(15 downto 0);
           alarm_1     : in STD_LOGIC;
           enable_1    : out STD_LOGIC;
           wait_time_2 : out std_logic_vector(15 downto 0);
           alarm_2     : in STD_LOGIC;
           enable_2    : out STD_LOGIC;
           usclk : in STD_LOGIC
           );
end motor;

architecture Behavioral of motor is


COMPONENT pwm is
    Port ( enable : in  STD_LOGIC;
           usclk : in  STD_LOGIC;
           power : in  STD_LOGIC_VECTOR(31 downto 0);  -- u seconds on
           period : in  STD_LOGIC_VECTOR(31 downto 0); -- u seconds
           pulse : out  STD_LOGIC
           );
 END COMPONENT;
 
 
    --Inputs
   signal power  : STD_LOGIC_VECTOR(31 downto 0) := std_logic_vector(to_unsigned(300, 32)); 
 
 	--Outputs
   signal pulse : STD_LOGIC;
   
   signal motor_ena_i : std_logic;
   signal motor_enb_i : std_logic;
 begin
 
 
  pwmInst :  pwm PORT MAP (
          enable => '1',
          usclk => usclk,
          power => power,
          period => std_logic_vector(to_unsigned(8192, 32)),
          pulse => pulse
        );

    power (9 downto 0) <= (others => speed(2));
    power (31 downto 13) <= (others => '0');
    power(12 downto 10) <= speed;
  
    wait_time_1 <= "0000000000000100";
    wait_time_2 <= "0000000000000100";
    
    enable_1 <= '1';
    enable_2 <= '1'; 
    
    motor_ena <= motor_ena_i and pulse;
    motor_enb <= motor_enb_i and pulse;
    
    turn_proc : process(turn, speed)
    begin      
        if turn = "010" then
    	    motor_ena_i <= '0';
        else
            motor_ena_i <= speed(0) or speed(1) or speed(2);
        end if;
        if turn = "011" then
            motor_enb_i <= '0';
        else
            motor_enb_i <= speed(0) or speed(1) or speed(2);
        end if;
    
        if turn = "001" then
            motor_in1 <= NOT(forward);
            motor_in2 <= forward;
        else
            motor_in1 <= forward;
            motor_in2 <= NOT(forward);
        end if;
        if turn = "100" then
            motor_in4 <= NOT(forward);
            motor_in3 <= forward;
        else
            motor_in4 <= forward;
            motor_in3 <= NOT(forward);
        end if;
    end process turn_proc;
end Behavioral;

