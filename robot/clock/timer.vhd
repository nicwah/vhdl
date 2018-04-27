library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
    Port ( waittime : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           alarm : out  STD_LOGIC;
           msclk : in  STD_LOGIC);
end timer;

architecture Behavioral of timer is

begin


end Behavioral;

