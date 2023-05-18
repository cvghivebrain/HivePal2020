=========================================================================================
	HivePal v2.2
=========================================================================================

HivePal is a palette editor for Sega Mega Drive games, written in Delphi. It can view and
edit palettes in both full ROMs and split disassemblies.

Release Notes For v2.2:
----------------------
* Added menu for different brightness schemes. These are:
  * Real - Hardware accurate actual values, determined by Tiido.
  * Shadow - Darker colours from shadow/highlight mode.
  * Highlight - Brighter colours from shadow/highlight mode.
  * Genecyst - Slightly dimmer colours used by Genecyst and other old emulators.
* Added support for little-endian palettes (e.g. Sonic & Knuckles Collection).
* Added exporting of current palette to BIN and TPL (Tile Layer Pro) formats.
* Added animated palette viewer.
* Fixed bug where "Under Mouse" value was not cleared when the mouse moved off screen.

Release Notes For v2.1:
----------------------
* Initial release. Complete rewrite of HivePal v0.3.


=========================================================================================
	Usage
=========================================================================================

 ----------------------------------------------
 |  -----------------------   --------------  |
 | | Loading Menu          | |              | |
 |  -----------------------  |              | |
 |  -----------------------  |              | |
 | |                       | | (3)          | |
 | | (1)                   | |              | |
 | |                       | |              | |
 |  -----------------------  |              | |
 | | (2)                   | |              | |
 |  -----------------------  |              | |
 | | (4)                   | |              | |
 |  -----------------------   --------------  |
 |  ----------------------------------------  |
 | | (5)                                    | |
 |  ----------------------------------------  |
 ----------------------------------------------

1. Palette selector. Appears when a palette has been loaded. Select multiple colours by
   click-dragging or right clicking on the second colour you want.

2. Colour menu. Edit the selected colour manually with the RGB bars, or by using the bit
   editor below them. "Advanced Colour Menu" brings up a standard Windows colour menu.
   
3. Palette browser. Displays the entire contents of the ROM or file as a palette. Invalid
   palettes appear grey, but you can override this with "Show Invalid Palettes". Click on
   a colour to load it in the palette selector.

4. Animation viewer. Shows a preview animated palette up to 6 colours wide. Modifying
   colours while the preview is running will update it in real time. A delay of 60 
   equates to 1 frame per second. A delay of 1-2 may cause the whole program to flicker.

5. ASM editor. Displays the current palette as assembly text. Changes made using the ASM
   editor must be committed by clicking "Update ASM Changes to Palette". This is not
   automatic. You can't change the length of the palette with this. Each line must start
   with "dc.w". Each colour must start with a "$" symbol or it will be interpreted as
   decimal instead of hex.


=========================================================================================
	Credits
=========================================================================================

* Tiido - Hardware accurate colour brightness values.
* MainMemory & MarkeyJester - Feature suggestions.
