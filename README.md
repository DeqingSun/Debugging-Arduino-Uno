# Debugging Arduino Uno with opensource toolchain

## Overview

![set img](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/tiny_minipro.jpg)

Arduino with an AVR8 microcontroller can be debugged with debugWIRE. This is often done with a debugger from Atmel and Avr Studio.

I found the [dwire-debug](https://github.com/dcwbrown/dwire-debug) project which contains an opensource implementation of debugging probe and server.

On computer side, Visual Studio Code is capable to debug ARM based Arduino, here I will also share how to setup VScode for debugging Uno.

The dwire project can use an FT232 or CH340 as debugging probe. However, debugWIRE may require changing fuses occasionally. So I used an Attiny85 both as ISP programmer and debugger.

## Hardware I used

![schematic](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/tiny_minipro_bb.png)

Here I used a Digispark board as debugging probe with [dwire-debug's firmware](https://github.com/dcwbrown/dwire-debug/blob/master/usbtiny/main.hex). I used an Arduino Mini Pro as the target. Arduino Mini Pro shares the same core hardware with Uno. Since I'm going to disable bootloader, there will be no different on the software side. 

One advantage of mini pro is the absence of serial downloader. If you are using an Uno board, you may need to cut the RESET-EN trace to avoid interference with the serial downloader.

## Step 1, convert Digispark to debugging probe

