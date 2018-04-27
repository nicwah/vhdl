library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
    Port ( waittime : in  STD_LOGIC_VECTOR(15 downto 0);
           enable : in  STD_LOGIC;
           alarm : out  STD_LOGIC;
           msclk : in  STD_LOGIC);
end timer;

architecture Behavioral of timer is

begin
	process(msclk)
		variable counter : integer range 0 to 655535 :=0;
	begin
		if falling_edge(msclk) and enable='1' then
			counter := counter + 1;
			if counter = to_integer(unsigned(waittime)) then
				alarm <= '1';
				counter := 0;
			else
				alarm <= '0';
			end if;
		else
			alarm <= '0';
		end if;
	end process;
end Behavioral;

