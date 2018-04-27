

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
    Port ( sysclk : in  STD_LOGIC; -- system clock 50Mhz
           msclk : out  STD_LOGIC;
           usclk : out  STD_LOGIC);
end clock;

architecture Behavioral of clock is
begin
	clock_proc : process(sysclk)
		variable mdivider : integer range 0 to 50000 :=0;
		variable udivider : integer range 0 to 50 := 0;
	begin
		if rising_edge(sysclk) then
			-- Milli
			mdivider:=mdivider+1;
 			if mdivider < 25000 then
				msclk <= 1;
			else
				msclk <= 0;
			end if;			
			if mdivider = 50000 then
			    mdivider:=0;
			end if;
			-- Micro
			udivider:=udivider+1;
 			if udivider < 25 then
				usclk <= 1;
			else
				usclk <= 0;
			end if;			
			if udivider = 50 then
			    udivider:=0;
			end if;
		end if;
	end process clock_proc;
end Behavioral;

