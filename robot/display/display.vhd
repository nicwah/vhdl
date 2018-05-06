----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:34 04/27/2018 
-- Design Name: 
-- Module Name:    motor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    port ( msclk : in std_logic;                                -- digit update clock
           display_value : in std_logic_vector(15 downto 0);    -- displayed value (0x0000 - 0xFFFF)
           precision : in std_logic_vector(1 downto 0);         -- decimal position
           an : out std_logic_vector(3 downto 0);
           seg : out std_logic_vector(6 downto 0);
           dp : out std_logic);
end entity;

architecture Behavioral of display is

    signal position : std_logic_vector(1 downto 0) := "11";  -- current display position (from right)
    signal digit : std_logic_vector(3 downto 0) := "0000";   -- current displayed digit

begin

    an <= "0111" when position = "11" else
          "1011" when position = "10" else
          "1101" when position = "01" else
          "1110";
          
    digit <= display_value(15 downto 12) when position = "11" else
             display_value(11 downto 8) when position = "10" else
             display_value(7 downto 4) when position = "01" else
             display_value(3 downto 0);
           
    dp <= '0' when position = precision else '1';

-- segment encoding
--      0
--     ---  
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3
   
    with digit select
        seg <= "1111001" when "0001",   --1
               "0100100" when "0010",   --2
               "0110000" when "0011",   --3
               "0011001" when "0100",   --4
               "0010010" when "0101",   --5
               "0000010" when "0110",   --6
               "1111000" when "0111",   --7
               "0000000" when "1000",   --8
               "0010000" when "1001",   --9
               "0001000" when "1010",   --A
               "0000011" when "1011",   --b
               "1000110" when "1100",   --C
               "0100001" when "1101",   --d
               "0000110" when "1110",   --E
               "0001110" when "1111",   --F
               "1000000" when others;   --0

    process(msclk)
    begin
        if rising_edge(msclk) then
            position <= position - 1;
        end if;
    end process;

end Behavioral;

