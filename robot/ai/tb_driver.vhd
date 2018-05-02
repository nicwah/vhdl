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
         mclk : in std_logic;
         line_sensor : in std_logic_vector(2 downto 0);
         speed : out std_logic_vector(2 downto 0);
         forward : out std_logic;
         turn : out std_logic_vector (2 downto 0)
        );
    END COMPONENT;
    
    --Inputs
    signal mclk : std_logic := '0';
    signal line_sensor : std_logic_vector(2 downto 0) := "000";
    
 	--Outputs
    signal speed : std_logic_vector(2 downto 0);
    signal forward : std_logic;
    signal turn : std_logic_vector (2 downto 0);
	
    constant clock_interval : time := 20 ns;
    
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: driver PORT MAP (
          mclk => mclk,
          line_sensor => line_sensor,
          speed => speed,
          forward => forward,
          turn => turn
        );

    -- Clock process
    clock_prc: process
    begin
        mclk <= '1';
        wait for clock_interval/2;
        mclk <= '0';
        wait for clock_interval/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        -- wait for start line => drive straight
        line_sensor <= "101";
        wait for clock_interval;

        -- drive straight
        line_sensor <= "010";
        wait for clock_interval;

        -- drive straight => turn left
        line_sensor <= "110";
        wait for clock_interval;

        -- turn left => turn right
        line_sensor <= "011";
        wait for clock_interval;

        -- turn right => drive straight
        line_sensor <= "010";
        wait for clock_interval;

        -- drive straight => stop
        line_sensor <= "111";
        wait for clock_interval;

        -- stop => wait for start line
        wait for clock_interval;

        wait;
    end process;

END;
