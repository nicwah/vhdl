library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
    Port ( enable : in  STD_LOGIC;
           usclk : in  STD_LOGIC;
           power : in  STD_LOGIC_VECTOR(31 downto 0);  -- u seconds on
           period : in  STD_LOGIC_VECTOR(31 downto 0); -- u seconds
           pulse : out  STD_LOGIC
           );
end pwm;

architecture Behavioral of pwm is
  signal pulse_signal : STD_LOGIC := '0';
begin

    pulse <= pulse_signal and enable; 
 
	process(usclk)
		variable counter : integer range 0 to 2000000000 := 0; -- max 2 second
	begin
        if enable = '0' then 
            counter := 0;
        elsif rising_edge(usclk) then
			counter := counter + 1;
			if counter < to_integer(unsigned(power)) then
				pulse_signal <= '1';
			else
				pulse_signal <= '0';
			end if; 
            if counter > to_integer(unsigned(period)) then
                counter := 0;
             end if;
		end if;
	end process;
end Behavioral;

