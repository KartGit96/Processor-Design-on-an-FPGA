library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.dmem.all;

entity DataMemory is
    Port ( ALUResult : in STD_LOGIC_VECTOR (31 downto 0);
           clk, MemWrite, Mem2Reg,clr: in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR(31 downto 0);
           ukey : in STD_LOGIC_VECTOR(127 downto 0);
           din : in STD_LOGIC_VECTOR(63 downto 0);
           Result : out STD_LOGIC_VECTOR (31 downto 0);
           dmem : out data_out);
end DataMemory;

architecture Behavioral of DataMemory is

signal ReadData : std_logic_vector (31 downto 0):=(others=>'0');
signal dmem1 : data_out:= data_out'(
 x"b7",x"e1",x"51",x"63",
 x"56",x"18",x"cb",x"1c", 
 x"f4",x"50",x"44",x"d5", 
 x"92",x"87",x"be",x"8e", 
 x"30",x"bf",x"38",x"47", 
 x"ce",x"f6",x"b2",x"00", 
 x"6d",x"2e",x"2b",x"b9", 
 x"0b",x"65",x"a5",x"72", 
 x"a9",x"9d",x"1f",x"2b",
 x"47",x"d4",x"98",x"e4",
 x"e6",x"0c",x"12",x"9d", 
 x"84",x"43",x"8c",x"56", 
 x"22",x"7b",x"06",x"0f", 
 x"c0",x"b2",x"7f",x"c8", 
 x"5e",x"e9",x"f9",x"81", 
 x"fd",x"21",x"73",x"3a", 
 x"9b",x"58",x"ec",x"f3", 
 x"39",x"90",x"66",x"ac", 
 x"d7",x"c7",x"e0",x"65",
 x"75",x"ff",x"5a",x"1e", 
 x"14",x"36",x"d3",x"d7", 
 x"b2",x"6e",x"4d",x"90", 
 x"50",x"a5",x"c7",x"49", 
 x"ee",x"dd",x"41",x"02", 
 x"8d",x"14",x"ba",x"bb", 
 x"2b",x"4c",x"34",x"74",
 x"00",x"00",x"00",x"00", --ukey --26
 x"00",x"00",x"00",x"00", --ukey --27
 x"00",x"00",x"00",x"00", --ukey --28
 x"00",x"00",x"00",x"00", --ukey --29
 x"00",x"00",x"00",x"00", --A    --30
 x"00",x"00",x"00",x"00", --B    --31
  x"80",x"00",x"00",x"00", --and operation
  x"00",x"00",x"00",x"00",
  x"00",x"00",x"00",x"00",
  x"00",x"00",x"00",x"00",
  x"00",x"00",x"00",x"00",
  x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
     x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
      x"00",x"00",x"00",x"00",
          x"00",x"00",x"00",x"00",
          x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
           x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
            x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
             x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
              x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
               x"00",x"00",x"00",x"00",
                x"00",x"00",x"00",x"00",
                x"00",x"00",x"00",x"00",
                   x"00",x"00",x"00",x"00",
                   x"00",x"00",x"00",x"00",
                                  x"00",x"00",x"00",x"00",
                                  x"00",x"00",x"00",x"00",
                                   x"00",x"00",x"00",x"00",
                                   x"00",x"00",x"00",x"00",
                                      x"00",x"00",x"00",x"00",
                           x"00",x"00",x"00",x"00",
                           x"00",x"00",x"00",x"00",
                           x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                            x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",
                             x"00",x"00",x"00",x"00",                
          
x"00",x"00",x"00",x"00",
 x"00",x"00",x"00",x"00"                                           
      );
 
 
signal address,a2: std_logic_vector (31 downto 0);
signal Readmem: Std_logic;
constant t : std_logic_vector(31 downto 0) := x"000001DD" ;
signal c : boolean;
begin
a2 <= ALUResult(29 downto 0) & "00";
--a1 <= unsigned(conv_integer(unsigned(a2)));
process(c,a2)
begin
if (a2<t) then c <= true; address <= a2;
else c<= false; address <= (others =>'0');
end if;
end process;


--process(c)
--begin
--if c then address<= ALUResult(29 downto 0) & "00";
-- else
--    address <= (others=>'0');
--    end if;
--end process;

Readmem <= Mem2Reg;

process(clk,MemWrite,clr)
begin
if (clr = '1') then
dmem1(0) <= x"b7";dmem1(1) <= x"e1";dmem1(2) <= x"51";dmem1(3) <= x"63"; --00
dmem1(4) <= x"56";dmem1(5) <= x"18";dmem1(6) <= x"cb";dmem1(7) <= x"1c"; --01
dmem1(8) <= x"f4";dmem1(9) <= x"50";dmem1(10) <= x"44";dmem1(11) <= x"d5"; 
dmem1(12) <= x"92";dmem1(13) <= x"87";dmem1(14) <= x"be";dmem1(15) <= x"8e";
dmem1(16) <= x"30";dmem1(17) <= x"bf";dmem1(18) <= x"38";dmem1(19) <= x"47"; 
dmem1(20) <= x"ce";dmem1(21) <= x"f6";dmem1(22) <= x"b2";dmem1(23) <= x"00"; 
dmem1(24) <= x"6d";dmem1(25) <= x"2e";dmem1(26) <= x"2b";dmem1(27) <= x"b9"; 
dmem1(28) <= x"0b";dmem1(29) <= x"65";dmem1(30) <= x"a5";dmem1(31) <= x"72"; 
dmem1(32) <= x"a9";dmem1(33) <= x"9d";dmem1(34) <= x"1f";dmem1(35) <= x"2b";
dmem1(36) <= x"47";dmem1(37) <= x"d4";dmem1(38) <= x"98";dmem1(39) <= x"e4";
dmem1(40) <= x"e6";dmem1(41) <= x"0c";dmem1(42) <= x"12";dmem1(43) <= x"9d"; 
dmem1(44) <= x"84";dmem1(45) <= x"43";dmem1(46) <= x"8c";dmem1(47) <= x"56"; 
dmem1(48) <= x"22";dmem1(49) <= x"7b";dmem1(50) <= x"06";dmem1(51) <= x"0f"; 
dmem1(52) <= x"c0";dmem1(53) <= x"b2";dmem1(54) <= x"7f";dmem1(55) <= x"c8"; 
dmem1(56) <= x"5e";dmem1(57) <= x"e9";dmem1(58) <= x"f9";dmem1(59) <= x"81"; 
dmem1(60) <= x"fd";dmem1(61) <= x"21";dmem1(62) <= x"73";dmem1(63) <= x"3a"; 
dmem1(64) <= x"9b";dmem1(65) <= x"58";dmem1(66) <= x"ec";dmem1(67) <= x"f3"; 
dmem1(68) <= x"39";dmem1(69) <= x"90";dmem1(70) <= x"66";dmem1(71) <= x"ac"; 
dmem1(72) <= x"d7";dmem1(73) <= x"c7";dmem1(74) <= x"e0";dmem1(75) <= x"65";
dmem1(76) <= x"75";dmem1(77) <= x"ff";dmem1(78) <= x"5a";dmem1(79) <= x"1e"; 
dmem1(80) <= x"14";dmem1(81) <= x"36";dmem1(82) <= x"d3";dmem1(83) <= x"d7"; 
dmem1(84) <= x"b2";dmem1(85) <= x"6e";dmem1(86) <= x"4d";dmem1(87) <= x"90"; 
dmem1(88) <= x"50";dmem1(89) <= x"a5";dmem1(90) <= x"c7";dmem1(91) <= x"49"; 
dmem1(92) <= x"ee";dmem1(93) <= x"dd";dmem1(94) <= x"41";dmem1(95) <= x"02"; 
dmem1(96) <= x"8d";dmem1(97) <= x"14";dmem1(98) <= x"ba";dmem1(99) <= x"bb"; 
dmem1(100) <= x"2b";dmem1(101) <= x"4c";dmem1(102) <= x"34";dmem1(103) <= x"74"; ---s(25)
dmem1(104) <= ukey(31 downto 24);dmem1(105) <= ukey(23 downto 16);dmem1(106) <= ukey(15 downto 8);dmem1(107) <= ukey(7 downto 0);  --26
dmem1(108) <= ukey(63 downto 56);dmem1(109) <= ukey(55 downto 48);dmem1(110) <= ukey(47 downto 40);dmem1(111) <= ukey(39 downto 32);  --27
dmem1(112) <= ukey(95 downto 88);dmem1(113) <= ukey(87 downto 80);dmem1(114) <= ukey(79 downto 72);dmem1(115) <= ukey(71 downto 64);  --28
dmem1(116) <= ukey(127 downto 120);dmem1(117) <= ukey(119 downto 112);dmem1(118) <= ukey(111 downto 104);dmem1(119) <= ukey(103 downto 96);  --29
dmem1(120) <= din(63 downto 56);dmem1(121) <= din(55 downto 48);dmem1(122) <= din(47 downto 40);dmem1(123) <= din(39 downto 32);  --30 (A
dmem1(124) <= din(31 downto 24);dmem1(125) <= din(23 downto 16);dmem1(126) <= din(15 downto 8);dmem1(127) <= din(7 downto 0);  --31  (B)
dmem1(128) <= x"80"; elsif (rising_edge(clk)) then
    if (MemWrite = '1') then
        dmem1(conv_integer(unsigned(address))) <= WD(31 downto 24);
        dmem1(conv_integer(unsigned(address+1))) <= WD(23 downto 16);
        dmem1(conv_integer(unsigned(address+2))) <= WD(15 downto 8);
        dmem1(conv_integer(unsigned(address+3))) <= WD(7 downto 0);
    end if;
end if;
end process;

with ReadMeM select
ReadData <= (dmem1(conv_integer((address))) & dmem1(conv_integer((address+1)))&
            dmem1(conv_integer((address+2))) & dmem1(conv_integer((address+3))))
             when '1', x"00000000" when others;

--process(c, ALUResult,Mem2Reg)
--begin
--case Mem2Reg is 
-- when '1' => if c then 
--               address <= ALUResult(29 downto 0) & "00";
--               ReadData <= (dmem1(conv_integer((address))) & dmem1(conv_integer((address+1)))&
--               dmem1(conv_integer((address+2))) & dmem1(conv_integer((address+3))));
--               Result <= ReadData;
--             else
--                address <= (others => '0');
--                ReadData <= (dmem1(conv_integer((address))) & dmem1(conv_integer((address+1)))&
--                            dmem1(conv_integer((address+2))) & dmem1(conv_integer((address+3))));
--                Result <= ReadData;             
--             end if;
-- when '0' => ReadData <= (others => '0');
--             Result <= ALUResult;
-- when others => null;
--end case;                           
--end process;

--process(Mem2Reg,ALUResult,ReadData)
--begin 
--case Mem2Reg is 
--    when '0' => Result <= ALUResult;
--    when '1' => Result <= ReadData;
--    when others => null;
--end case;    
--end process;

Result <= ALUResult when (Mem2Reg = '0')
          else ReadData when (Mem2Reg = '1');

--dmem <= dmem2 when clr ='1' else
        --dmem1;
dmem <= dmem1;        
end Behavioral;
