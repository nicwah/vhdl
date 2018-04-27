----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:13 04/27/2018 
-- Design Name: 
-- Module Name:    top_robot - Behavioral 
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

entity top_robot is
    Port ( mclk : in STD_LOGIC;
           btn : in std_logic_vector(3 downto 0); 
           sw : in std_logic_vector(7 downto 0);
           led : out std_logic_vector(7 downto 0);
           pio : inout std_logic_vector(87 downto 72));
end top_robot;

architecture Behavioral of top_robot is

alias linetracking : std_logic_vector(2 downto 0) is pio(74 downto 72);
alias servo_out : std_logic is pio(75);
alias motor_ena : std_logic is pio(81);  -- Left motor speed
alias motor_enb : std_logic is pio(80);  -- Right motor speed
alias motor_in1 : std_logic is pio(79);  -- Left motor control
alias motor_in2 : std_logic is pio(78);  -- Left motor control
alias motor_in3 : std_logic is pio(77);  -- Right motor control
alias motor_in4 : std_logic is pio(76);  -- Right motor control
alias usonic_in : std_logic is pio(82);
alias usonic_out : std_logic is pio(83);
alias ir_in : std_logic is pio(84);
alias bluetooth_out : std_logic is pio(87);
alias bluetooth_in : std_logic is pio(86);

component timer
    port(
        
    );

component clock
    port(
        sysclk : in std_logic;
    );
end component;

component motor
    Port ( speed : in  STD_LOGIC_VECTOR (2 downto 0);
           dir : in  STD_LOGIC;
           motor_ena : out  STD_LOGIC;
           motor_enb : out  STD_LOGIC;
           motor_in1 : out  STD_LOGIC;
           motor_in2 : out  STD_LOGIC;
           motor_in3 : out  STD_LOGIC;
           motor_in4 : out  STD_LOGIC);
end component;

component driver
    Port ( alarm : in  STD_LOGIC;
           speed : out  STD_LOGIC_VECTOR (2 downto 0);
           direction : out  STD_LOGIC);
end component;

begin

    signal speed : STD_LOGIC_VECTOR (2 downto 0);

    ClockInst : clock
        port map (
            mclk => sysclk;
        );
        
    MotorInst : motor
        port map (
           speed => speed;
           dir => dir;
           motor_ena => motor_ena;
           motor_enb => motor_enb;
           motor_in1 => motor_in1;
           motor_in2 => motor_in2;
           motor_in3 => motor_in3;
           motor_in4 => motor_in4;
        );

    DriverInst : driver
        port map (
            alarm => driver_alarm;
            speed => speed;
            direction => dir;
        );

    DriverTimerInst : timer
        port map (
            wait_time => driver_wait_time;
            alarm => driver_alarm;
            enable => driver_enable;
            ms_clock => ms_clock;
        );

    MotorTimer1Inst : timer
        port map (
            wait_time => motor_wait_time_1;
            alarm => motor_alarm_1;
            enable => motor_enable_1;
            ms_clock => ms_clock;
        );

    MotorTimer2Inst : timer
        port map (
            wait_time => motor_wait_time_2;
            alarm => motor_alarm_2;
            enable => motor_enable_2;
            ms_clock => ms_clock;
        );

end Behavioral;

