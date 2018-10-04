-- this unit is modified to work with Sockit triple DAC
-- This unit generates control signals only
-- My input clk is 50 MHz
-- Now we can get Horizontal, Vertical counters in output in std_logic_vector format
 
----------------------------------------------------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 ----------------------------------------------------------
 ENTITY vga_timing_signals_generator IS
 GENERIC (
 Ha: INTEGER := 96;  --Hpulse
 Hb: INTEGER := 144; --Hpulse+HBP
 Hc: INTEGER := 784; --Hpulse+HBP+Hactive
 Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
 Va: INTEGER := 2;   --Vpulse
 Vb: INTEGER := 35;  --Vpulse+VBP
 Vc: INTEGER := 515; --Vpulse+VBP+Vactive
 Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
 PORT (
 clk_50:               IN STD_LOGIC; ----50MHz in our board
 pixel_clk_out:        out STD_LOGIC;
 Hsync_out, Vsync_out: out STD_LOGIC;
 hcnt_addr:            OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
 vcnt_addr:            OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
 display_EN:           out std_logic;
 nblanck, nsync:       OUT STD_LOGIC);

 END entity;
 ----------------------------------------------------------
 ARCHITECTURE behave OF vga_timing_signals_generator IS
 SIGNAL Hactive, Vactive, dena: STD_LOGIC;
 signal pixel_clk : std_LOGIC := '0';
 signal Hsync, Vsync : STD_LOGIC;
 signal Hcount_out: INTEGER RANGE 0 TO Hd;
 signal Vcount_out: INTEGER RANGE 0 TO Vd;
 BEGIN
 -------------------------------------------------------
-- CONTROL GENERATOR
 -------------------------------------------------------
 --Static signals for DACs:
 nblanck <= '1'; --no direct blanking
 nsync <= '0'; --no sync on green
 
 --Create pixel clock (50MHz->25MHz):
 PROCESS (clk_50)
 BEGIN
 IF (clk_50'EVENT AND clk_50='1') THEN
 pixel_clk <= NOT pixel_clk;
 END IF;
 END PROCESS;
 
 PROCESS (pixel_clk)
 VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
 BEGIN
 IF (pixel_clk'EVENT AND pixel_clk='1') THEN
 Hcount := Hcount + 1;
 IF (Hcount=Ha) THEN
 Hsync <= '1';
 ELSIF (Hcount=Hb) THEN
 Hactive <= '1';
 ELSIF (Hcount=Hc) THEN
 Hactive <= '0';
 ELSIF (Hcount=Hd) THEN
 Hsync <= '0';
 Hcount := 0;
 END IF;
 END IF;
 Hcount_out <= Hcount;
END PROCESS;
 --Vertical signals generation:
 PROCESS (Hsync)
 VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
 BEGIN
 IF (Hsync'EVENT AND Hsync='0') THEN
 Vcount := Vcount + 1;
 IF (Vcount=Va) THEN
 Vsync <= '1';
ELSIF (Vcount=Vb) THEN
 Vactive <= '1';
 ELSIF (Vcount=Vc) THEN
 Vactive <= '0';
 ELSIF (Vcount=Vd) THEN
 Vsync <= '0';
 Vcount := 0;
 END IF;
 END IF;
 Vcount_out <= Vcount;
 END PROCESS;
 ---Display enable generation:
 dena <= Hactive AND Vactive;
 
 display_EN <= dena;
 Hsync_out <= Hsync;
 Vsync_out <= Vsync;
 hcnt_addr <= std_logic_vector(to_unsigned(Hcount_out, 10));
 vcnt_addr <= std_logic_vector(to_unsigned(Vcount_out, 10));
 pixel_clk_out <= pixel_clk;
 END architecture;