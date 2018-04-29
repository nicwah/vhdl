--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:40:47 04/27/2018
-- Design Name:   
-- Module Name:   /home/torbjorn/vhdl/robot/motor_tb.vhd
-- Project Name:  robot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: motor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY motor_tb IS
END motor_tb;
 
ARCHITECTURE behavior OF motor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT motor
    PORT(
         speed : IN  std_logic_vector(2 downto 0);
         forward : IN  std_logic;
         turn : in  STD_LOGIC_VECTOR (2 downto 0);
         motor_ena : OUT  std_logic;
         motor_enb : OUT  std_logic;
         motor_in1 : OUT  std_logic;
         motor_in2 : OUT  std_logic;
         motor_in3 : OUT  std_logic;
         motor_in4 : OUT  std_logic;
         wait_time_1 : out std_logic_vector(15 downto 0);
         alarm_1     : in STD_LOGIC;
         enable_1    : out STD_LOGIC;
         wait_time_2 : out std_logic_vector(15 downto 0);
         alarm_2     : in STD_LOGIC;
         enable_2    : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal speed : std_logic_vector(2 downto 0) := (others => '0');
   signal forward : std_logic := '1';
   signal turn :  STD_LOGIC_VECTOR (2 downto 0);
   signal alarm_1     : STD_LOGIC;
   signal alarm_2     : STD_LOGIC;
 
 	--Outputs
   signal motor_ena : std_logic;
   signal motor_enb : std_logic;
   signal motor_in1 : std_logic;
   signal motor_in2 : std_logic;
   signal motor_in3 : std_logic;
   signal motor_in4 : std_logic;
   signal wait_time_1 : std_logic_vector(15 downto 0);
   signal enable_1    : STD_LOGIC;
   signal wait_time_2 : std_logic_vector(15 downto 0);
   signal enable_2    : STD_LOGIC;

   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clock : std_logic;
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: motor PORT MAP (
          speed => speed,
          forward => forward,
          turn => turn,
          motor_ena => motor_ena,
          motor_enb => motor_enb,
          motor_in1 => motor_in1,
          motor_in2 => motor_in2,
          motor_in3 => motor_in3,
          motor_in4 => motor_in4,
          wait_time_1 => wait_time_1,
          alarm_1 => alarm_1,
          enable_1 => enable_1,
          wait_time_2 => wait_time_2,
          alarm_2 => alarm_2,
          enable_2 => enable_2
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for clock_period*10;
        -- forward
		speed <= "001";
		forward <= '1';
        turn <= "000";

      wait for clock_period*10;
        -- stop
		speed <= "000";
		forward <= '0';

      wait for clock_period*10;
        -- backward
		speed <= "001";
		forward <= '0';

      wait for clock_period*10;
        -- 90 degrees left
		speed <= "001";
		forward <= '1';
        turn <= "001";
        
      wait for clock_period*10;
        -- half turn left 
		speed <= "001";
		forward <= '1';
        turn <= "010";

      wait for clock_period*10;
        -- half turn right
		speed <= "001";
		forward <= '1';
        turn <= "011";
      
      wait for clock_period*10;
        -- 90 degrees right
		speed <= "001";
		forward <= '1';
        turn <= "100";

      wait;
   end process;

END;
