--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:42:29 04/18/2018
-- Design Name:   
-- Module Name:   /home/torbjorn/project/my_pryttel/my_tb.vhd
-- Project Name:  my_pryttel
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: state_machine
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
 
ENTITY my_tb IS
END my_tb;
 
ARCHITECTURE behavior OF my_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT state_machine
    PORT(
         btn : IN  std_logic_vector(3 downto 0);
         led : OUT  std_logic_vector(3 downto 0);
         mclk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal btn : std_logic_vector(3 downto 0) := (others => '0');
   signal mclk : std_logic := '0';

 	--Outputs
   signal led : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant mclk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: state_machine PORT MAP (
          btn => btn,
          led => led,
          mclk => mclk
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
        btn <= "0001";
        wait for mclk_period*10;
        btn <= "0010";
        wait for mclk_period*10;
        btn <= "0100";
        wait for mclk_period*10;
        btn <= "1000";
        wait for mclk_period*10;
        btn <= "0000";
        wait;
   end process;

END;
