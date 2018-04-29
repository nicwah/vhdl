-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
 COMPONENT pwm is
    Port ( enable : in  STD_LOGIC;
           usclk : in  STD_LOGIC;
           power : in  STD_LOGIC_VECTOR(31 downto 0);  -- u seconds on
           period : in  STD_LOGIC_VECTOR(31 downto 0); -- u seconds
           pulse : out  STD_LOGIC
           );
 END COMPONENT;
        

    --Inputs
   signal enable : STD_LOGIC := '0';
   signal usclk  : STD_LOGIC := '0';
   signal power  : STD_LOGIC_VECTOR(31 downto 0) := std_logic_vector(to_unsigned(300, 32)); 
   signal period : STD_LOGIC_VECTOR(31 downto 0) := std_logic_vector(to_unsigned(1000, 32));
 
 	--Outputs
   signal pulse : STD_LOGIC;

   -- Clock period definitions
   constant usclk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm PORT MAP (
          enable => enable,
          usclk => usclk,
          power => power,
          period => period,
          pulse => pulse
        );

   -- Clock process definitions
   usclk_process :process
   begin
		usclk <= '0';
		wait for usclk_period/2;
		usclk <= '1';
		wait for usclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 1 ms; -- 1ms	
      enable <= '1';
      
      wait for 10 ms; -- 5ms
      enable <= '0';
      
      wait for 3 ms; -- 3ms
      
      wait;
   end process;

END;
