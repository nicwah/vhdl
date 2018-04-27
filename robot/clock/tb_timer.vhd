LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_timer IS
END tb_timer;
 
ARCHITECTURE behavior OF tb_timer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT timer
    PORT(
         waittime : IN  std_logic_vector(15 downto 0);
         enable : IN  std_logic;
         alarm : OUT  std_logic;
         msclk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal waittime : std_logic_vector(15 downto 0) := "0000000001000000"; -- 64 ms
   signal enable : std_logic := '0';
   signal msclk : std_logic := '0';

 	--Outputs
   signal alarm : std_logic;

   -- Clock period definitions
   constant msclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: timer PORT MAP (
          waittime => waittime,
          enable => enable,
          alarm => alarm,
          msclk => msclk
        );

   -- Clock process definitions
   msclk_process :process
   begin
		msclk <= '0';
		wait for msclk_period/2;
		msclk <= '1';
		wait for msclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		enable <= '1';
      wait for msclk_period*200;
		enable <='0';
		wait for msclk_period*200;
      -- insert stimulus here 

      wait;
   end process;

END;
