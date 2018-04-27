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
         dir : IN  std_logic;
         motor_ena : OUT  std_logic;
         motor_enb : OUT  std_logic;
         motor_in1 : OUT  std_logic;
         motor_in2 : OUT  std_logic;
         motor_in3 : OUT  std_logic;
         motor_in4 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal speed : std_logic_vector(2 downto 0) := (others => '0');
   signal dir : std_logic := '0';

 	--Outputs
   signal motor_ena : std_logic;
   signal motor_enb : std_logic;
   signal motor_in1 : std_logic;
   signal motor_in2 : std_logic;
   signal motor_in3 : std_logic;
   signal motor_in4 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clock : std_logic;
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: motor PORT MAP (
          speed => speed,
          dir => dir,
          motor_ena => motor_ena,
          motor_enb => motor_enb,
          motor_in1 => motor_in1,
          motor_in2 => motor_in2,
          motor_in3 => motor_in3,
          motor_in4 => motor_in4
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

		speed <= "001";
		dir <= '1';

      wait for clock_period*10;

		speed <= "000";
		dir <= '0';

      wait for clock_period*10;

		speed <= "001";
		dir <= '0';

      wait for clock_period*10;

		speed <= "000";
		dir <= '1';

      wait;
   end process;

END;
