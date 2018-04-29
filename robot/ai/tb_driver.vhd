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
         alarm : in std_logic;
         line_sensor : in std_logic_vector(2 downto 0);
         speed : out std_logic_vector(2 downto 0);
         forward : out std_logic;
         turn : out std_logic_vector (2 downto 0);
         wait_time : out std_logic_vector(15 downto 0);
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
    signal wait_time : std_logic_vector(15 downto 0);
    signal enable_timer : std_logic;
	
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
        line_sensor <= "000";

        -- idle => toggle
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';
        
        wait for 20 ns;

        -- toggle => drive past line
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';
        
        wait for 20 ns;

        -- drive past line => drive until line found
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';

        -- drive until line found
        wait for 100 ns;

        -- drive until line found => stop
        line_sensor <= "111";
        wait for 10 ns;
        line_sensor <= "000";

        wait for 20 ns;

        -- stop => toggle
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';
        
        wait for 20 ns;
        
        -- toggle => drive past line
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';        
        
        wait for 20 ns;
        
        -- drive past line => drive until line found
        alarm <= '1';
        wait for 10 ns;
        alarm <= '0';        

        -- drive until line found
        wait for 100 ns;            

        -- drive until line found => stop
        line_sensor <= "111";

        wait;
    end process;

END;
