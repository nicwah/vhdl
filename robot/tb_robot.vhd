--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:51:03 04/29/2018
-- Design Name:   
-- Module Name:   /home/torbjorn/git/vhdl/robot/tb_robot.vhd
-- Project Name:  robot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_robot
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
 
ENTITY tb_robot IS
END tb_robot;
 
ARCHITECTURE behavior OF tb_robot IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_robot
    PORT(
         mclk : IN  std_logic;
         btn : IN  std_logic_vector(3 downto 0);
         sw : IN  std_logic_vector(7 downto 0);
         led : OUT  std_logic_vector(7 downto 0);
         seg : OUT  std_logic_vector(6 downto 0);
         pio : INOUT  std_logic_vector(87 downto 72)
        );
    END COMPONENT;
    

   --Inputs
   signal mclk : std_logic := '0';
   signal btn : std_logic_vector(3 downto 0) := (others => '0');
   signal sw : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal pio : std_logic_vector(87 downto 72);

 	--Outputs
   signal led : std_logic_vector(7 downto 0);
   signal seg : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant mclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_robot PORT MAP (
          mclk => mclk,
          btn => btn,
          sw => sw,
          led => led,
          seg => seg,
          pio => pio
        );

   -- Clock process definitions
   mclk_process :process
   begin
		mclk <= '0';
		wait for mclk_period/2;
		mclk <= '1';
		wait for mclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for mclk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
