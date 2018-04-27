----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:58 03/13/2018 
-- Design Name: 
-- Module Name:    robot_controller - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity robot_controller is
    Port ( mclk : in STD_LOGIC;
           btn : in std_logic_vector(3 downto 0); 
           sw : in std_logic_vector(7 downto 0);
           led : out std_logic_vector(7 downto 0);
           pio : inout std_logic_vector(87 downto 72));
end robot_controller;

architecture Behavioral of robot_controller is

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

signal clk2k: STD_LOGIC;
signal counter : integer range 0 to 24999 := 0;

signal usonic_trigger : STD_LOGIC;

constant idle_state : std_logic_vector(1 downto 0) := "00";
constant pulse_state_1 : std_logic_vector(1 downto 0) := "01";
constant pulse_state_2 : std_logic_vector(1 downto 0) := "11";
signal state : std_logic_vector(1 downto 0) := (others => '0');

begin

    led(4 downto 1) <= "0000";
    led(5) <= linetracking(0);
    led(6) <= linetracking(1);
    led(7) <= linetracking(2);

    motor_ena <= sw(1);
    motor_enb <= sw(0);

    motor_in1 <= sw(3);
    motor_in2 <= not sw(3);
    motor_in3 <= sw(2);
    motor_in4 <= not sw(2);

    servo_out <= state(0);
    usonic_out <= '0';
    bluetooth_out <= '0';

    pio(82) <= '0';
    pio(84) <= '0';
    pio(85) <= '0';
    pio(86) <= '0';

    UsonicTrigger: process(clk2k)
        variable cnt : integer := 0;
    begin
        if rising_edge(clk2k) then
            if cnt = 30 then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
            
            case state is
                when idle_state =>
                    led(0) <= '0';
                    if cnt = 0 then
                        state <= pulse_state_1;
                    end if;
                when pulse_state_1 =>
                    led(0) <= '1';
                    if btn(0) = '1' then
                        state <= pulse_state_2;
                    else
                        state <= idle_state;
                    end if;
                when pulse_state_2 =>
                    state <= idle_state;
                when others =>
                    state <= idle_state;
            end case;
        end if;        
    end process;

    Counter20: process(clk2k)
    begin
        
    end process;

    FrequencyDivider: process(mclk)
    begin
        if rising_edge(mclk) then
            if (counter = 24999) then
                clk2k <= NOT(clk2k);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
end Behavioral;
