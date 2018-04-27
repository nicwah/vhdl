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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_driver IS
END tb_driver;
 
ARCHITECTURE behavior OF tb_driver IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver
    PORT(
         alarm : IN  std_logic;
         speed : OUT  std_logic_vector(2 downto 0);
         forward : out  std_logic;
         turn : out  std_logic_vector (2 downto 0);
         wait_time : out std_logic_vector (15 downto 0);
         enable_timer : out std_logic
        );
    END COMPONENT;
    
    --Inputs
    signal alarm : std_logic := '0';

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
        wait for 10 ns;	

        -- insert stimulus here 
        -- idle => toggle forward/backward
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        for I in 0 to 2 loop
        -- toggle forward/backward => drive
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        -- drive => turn right
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        -- turn right => turn left
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        -- turn left => turn ahead
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        -- turn ahead => stop
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        -- stop => toggle forward/backward
        alarm <= '1';
        wait for clock_interval;
        alarm <= '0';
        wait for 50 ns;

        end loop;

        wait;
    end process;

END;
