--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:25:07 04/27/2018
-- Design Name:   
-- Module Name:   /home/torbjorn/git/vhdl/robot/ai/tb_driver.vhd
-- Project Name:  robot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: driver
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
use ieee.numeric_std.all;
 
ENTITY tb_driver IS
END tb_driver;
 
ARCHITECTURE behavior OF tb_driver IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver
    PORT(
         alarm : in  std_logic;
         line_sensor : in std_logic_vector(2 downto 0);
         speed : out  std_logic_vector(2 downto 0);
         forward : out  std_logic;
         turn : out  std_logic_vector (2 downto 0);
         wait_time : out std_logic_vector (15 downto 0);
         enable_timer : out std_logic
        );
    END COMPONENT;
    
    --Inputs
    signal alarm : std_logic := '0';
    signal line_sensor : std_logic_vector(2 downto 0) := "000";
    
 	--Outputs
    signal speed : std_logic_vector(2 downto 0);
    signal forward : std_logic;
    signal turn : std_logic_vector (2 downto 0);
    signal wait_time : std_logic_vector (15 downto 0);
	signal enable_timer : std_logic;

	constant clock_interval : time := 20 ns;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: driver PORT MAP (
          alarm => alarm,
          line_sensor => line_sensor,
          speed => speed,
          forward => forward,
          turn => turn,
          wait_time => wait_time,
          enable_timer => enable_timer
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        -- insert stimulus here 

        -- idle => toggle forward/backward
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for clock_interval;

        for i in 1 to 7 loop
            line_sensor <= "000";

            -- toggle forward/backward => drive
            alarm <= '1';
            wait for clock_interval;
            alarm <= '0';
            wait for clock_interval;

            -- drive => stop
            line_sensor <= std_logic_vector(to_unsigned(i, line_sensor'length));
            wait for clock_interval;

            -- stop => toggle forward/backward
            alarm <= '1';
            wait for clock_interval;
            alarm <= '0';
            wait for clock_interval;

        end loop;

        wait;
    end process;

END;
