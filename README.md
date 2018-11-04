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

![original fuse](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/digispark_original_fuse)

This step requires updating firmware and fuse, so find your favourite ISP programmer. Be careful in this step as we are going to disable reset pin of Digispark. If you don't have a high-voltage programmer, you won't be able to program it anymore. 

My Digispark comes with `E1 DD FF` fuses. You should check if yours has the same fuse (unless you know how fuses work).

Get firmware from [dwire-debug's firmware](https://github.com/dcwbrown/dwire-debug/blob/master/usbtiny/main.hex), erase your attiny85, program and verify firmware.

Double check if everything is correct.

Now change the high fuse to `5D` (RSTDISBL programmed). If you did everything correctly, your Digispark should be functional now.

  

