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

signal speed : STD_LOGIC_VECTOR (2 downto 0);
signal actual_speed : STD_LOGIC_VECTOR (2 downto 0);
signal forward : std_logic;
signal turn : std_logic_vector(2 downto 0);
signal driver_alarm : std_logic;
signal driver_wait_time : std_logic_vector(15 downto 0);
signal driver_enable : std_logic;

signal motor_alarm_1 : std_logic;
signal motor_alarm_2 : std_logic;
signal motor_enable_1 : std_logic;
signal motor_enable_2 : std_logic;
signal motor_wait_time_1 : std_logic_vector(15 downto 0);
signal motor_wait_time_2 : std_logic_vector(15 downto 0);

signal usclk : std_logic;
signal msclk : std_logic;

component timer
    port(
        waittime : in std_logic_vector(15 downto 0);
        enable : in std_logic;
        alarm : out std_logic;
        msclk : in std_logic);
end component;

component clock
    port(
        sysclk : in std_logic;
        msclk : out  STD_LOGIC;
        usclk : out  STD_LOGIC);
end component;

component motor
    Port ( speed : in  STD_LOGIC_VECTOR (2 downto 0);
           forward : in  STD_LOGIC;
           turn : in STD_LOGIC_VECTOR(2 downto 0);
           motor_ena : out  STD_LOGIC;
           motor_enb : out  STD_LOGIC;
           motor_in1 : out  STD_LOGIC;
           motor_in2 : out  STD_LOGIC;
           motor_in3 : out  STD_LOGIC;
           motor_in4 : out  STD_LOGIC;
           wait_time_1 : out std_logic_vector(15 downto 0);
           alarm_1     : in STD_LOGIC;
           enable_1    : out STD_LOGIC;
           wait_time_2 : out std_logic_vector(15 downto 0);
           alarm_2     : in STD_LOGIC;
           enable_2    : out STD_LOGIC
);
end component;

component driver
    Port ( alarm : in  std_logic;
           speed : out  std_logic_vector (2 downto 0);
           forward : out  std_logic;
           turn : out  std_logic_vector (2 downto 0);
           wait_time : out std_logic_vector (15 downto 0);
           enable_timer : out std_logic);
end component;

begin

    led(0) <= forward;
    led(1) <= turn(0) or turn(1) or turn(2);
    led(2) <= driver_enable;
    led(3) <= motor_enable_1;
    led(4) <= motor_enable_2;

    actual_speed <= "000" when sw(0) = '0' else speed;

    ClockInst : clock
        port map (
            sysclk => mclk,
            usclk => usclk,
            msclk => msclk
        );
        
    MotorInst : motor
        port map (
           speed => actual_speed,
           forward => forward,
           turn => turn,
           motor_ena => motor_ena,
           motor_enb => motor_enb,
           motor_in1 => motor_in1,
           motor_in2 => motor_in2,
           motor_in3 => motor_in3,
           motor_in4 => motor_in4,
           wait_time_1 => motor_wait_time_1, 
           alarm_1 => motor_alarm_1,
           enable_1 => motor_enable_1,
           wait_time_2 => motor_wait_time_2, 
           alarm_2 => motor_alarm_2,
           enable_2 => motor_enable_2
        );

    DriverInst : driver
        port map (
            alarm => driver_alarm,
            speed => speed,
            forward => forward,
            turn => turn,
            wait_time => driver_wait_time,
            enable_timer => driver_enable
        );

    DriverTimerInst : timer
        port map (
            waittime => driver_wait_time,
            alarm => driver_alarm,
            enable => driver_enable,
            msclk => msclk
        );

    MotorTimer1Inst : timer
        port map (
            waittime => motor_wait_time_1,
            alarm => motor_alarm_1,
            enable => motor_enable_1,
            msclk => msclk
        );

    MotorTimer2Inst : timer
        port map (
            waittime => motor_wait_time_2,
            alarm => motor_alarm_2,
            enable => motor_enable_2,
            msclk => msclk
        );

end Behavioral;

