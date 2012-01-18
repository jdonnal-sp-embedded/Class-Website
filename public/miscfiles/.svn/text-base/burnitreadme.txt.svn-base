README for BurnIt v1.1

BurnIt needs to be assembled and the necessary firmware should be
burned into the ATMEGA on the board.  This README details the firmware
burning process and BurnIt usage.

Using BURNIT:

  First set the switch on BurnIt to the position of the chip to be
  programmed.  Next insert the chip with pin 1 facing in the same
  direction as the handle of the ZIF socket.  All chips should be
  inserted flush with the bottom of the ZIF connector closest to the
  center of the board.  Apply 15 V to BurnIt and connect a serial port.
  On the computer, set the baud rate to 9600 and follow prompts.  H
  gives a list of commands.  In general, typing "A" for "Auto" and then
  transferring the code as ASCII should work for all varieties of chips.

How to use the 2051:

  It takes the exact same assembly instructions as the 8051.  However,
  it has no external memory bus, so MOVX is pointless.  It has a full
  range of port one pins and all P3 pins except P3.6.  Most of the P3
  pins are multiplexed to other functions.  It does have onboard
  timer/counters and interrupt pins.
  
  Note: It needs a crystal or an oscillator driver.  Just like the 8051,
  it executes one instruction every 12 oscillator cycles.  The
  oscillator can drive XTAL1 and leave XTAL2 unconnected, or a crystal
  can be placed between those pins with appropriate capacitors.  The
  crystal can be either 12 MHz or 24 MHz, depending on the variety of
  2051 ordered.
  
  Note 2: This chip needs a simple Power On Reset circuit because it
  will fail to start if simply given power.  Basically any decent
  capacitor between RESET and PWR should work.  A 1 microfarad capacitor
  works well.

How to use the PIC:

  Use the "pcc" compiler to convert C source files into Intel Hex files.
  Type "pcc name-of-source.c".  At the BurnIt prompt, press "A" and then
  transfer the *.hex file to the device.  It will then burn the code to
  the inserted PIC.  Alternatively, press D for Download followed by P
  for Program.

How to use the GAL22V10:
  
  This can be programmed with either WinCupl or the stripped down ccupl.
  Simply type "ccupl name-of-source.pld" and it will generate a JED
  file.  Send that to BurnIt.
  
  It can also be programmed with WinCupl.  See the example file for CUPL
  syntax.  Simply load this file into WinCupl and click "Device
  Dependent Compile".  The *.jed file is the programming file for the
  22v10.

  Important notes: Pins 1-11 are inputs, and 13 is not used.  14-23 are
  inputs or outputs.  It can have registers and a clock if necessary.

Note on parts:

  This device can program PIC part numbers 16F627, 16F628, 16F627A, and
  16F628A in PDIP packages.  All parts accept 5 V, so all will work.
  
  It can program Atmel AT89C2051 parts with PDIP packaging.  All part
  numbers are AT89C2051-something.  The first two digits are either 12
  or 24.  Since we use a 12 MHz clock, either will work.  The next
  character is P or S indicating PDIP or SOIC.  We need PDIP.  The final
  letter is temperature.  Any will work, but probably C for commercial
  is easiest to find and least expensive.
  
  The final device is a Lattice Semiconductor GAL22V10 as a 5 V part in
  a 24 pin DIP package.  All will have a part number like
  GAL22V10D-something where something indicates propagation time,
  packaging, and current draw.  As long as it is a DIP (last character
  is a P), the propagation time and current draw are irrelevant for the
  purposes of the class.

How to program an ATMEGA with BurnIt firmware:

  First, take the hex file to the 38-600 lab and turn on one of the
  programming stations.  Start the ALL-11C program.
  
  Click the device menu in the upper left and select ATMEL from the
  manufacturer list.
  
  Click MPU/MCU from the radio button list on the left.  Then select
  ATMEGA644 (not ATMEGA644V) and click Run.
  
  A popup will appear about setting the calibration byte.  Just push OK.
  
  Put the chip in the ZIF socket the normal way.
  
  Click on the file menu and select Load File to Programmer Buffer.
  Select burnitAll.hex.  When asked what type it is, select Intel HEX
  and leave the Unused Bytes at 00.  Click OK.
  
  Now Click "Program" at the top.  Leave Program and Verify both checked
  and click Run.  If this gives an error, use the "Erase" button at the
  top to erase the chip, and try again.
  
  Now close that popup and click the Config button.  From a fresh
  atmega, change CKDIV8 to Disable(1) and click Program.  Now click HIGH
  at the bottom to see the next page of fuses.  The JTAGEN fuse needs to
  be changed to Disable(1).  You're done!
  
  If this is not a fresh chip, the correct settings are as follows:
  On the main screen:
  CKSEL = 0010
  SUT = 10
  CKOUT = 1
  CKDIV8 = Disable(1)

  Leave the BLB checkboxes unchecked
  
  Click HIGH:
  BOOTRST = 1
  BOOTSZ = 00
  EESAVE = 1
  WDTON = 1
  SPIEN = Enable(0)
  JTAGEN = Disable(1)
  OCDEN = 1
  
  Click EXTENDED:
  BODLEVEL = 111

  That's all there is to it!

