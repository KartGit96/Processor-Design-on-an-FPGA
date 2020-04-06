library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.registers.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity RegisterFile is
    Port ( Instr,WD3 : in STD_LOGIC_VECTOR (31 downto 0);
           WE3,clk,clr : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           reg_file :   out register_out;
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

signal A1,A2,A3 : std_logic_vector(4 downto 0);

signal reg: register_out := register_out'(x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"80000000" );

begin

A1 <= Instr(25 downto 21);
A2 <= Instr(20 downto 16);
A3 <= Instr(20 downto 16) when (RegDst = '0') else
      Instr(15 downto 11) when (RegDst = '1');

RD1 <= reg(conv_integer(unsigned(A1)));
RD2 <= reg(conv_integer(unsigned(A2)));

process(WE3, clk, clr)
begin
if (clr = '1') then
    reg <= (x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"00000000",
                                          x"00000000",x"80000000" );
    elsif (rising_edge(clk)) then
        if (WE3 = '1') then
        reg(conv_integer(unsigned(A3))) <= WD3;
    end if;
end if;
end process;

reg_file <= reg;
end Behavioral;
