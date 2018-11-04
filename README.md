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

![original fuse](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/digispark_original_fuse.png)

This step requires updating firmware and fuse, so find your favourite ISP programmer. Be careful in this step as we are going to disable reset pin of Digispark. If you don't have a high-voltage programmer, you won't be able to program it anymore. 

My Digispark comes with `E1 DD FF` fuses. You should check if yours has the same fuse (unless you know how fuses work).

Get firmware from [dwire-debug's firmware](https://github.com/dcwbrown/dwire-debug/blob/master/usbtiny/main.hex), erase your attiny85, program and verify firmware.

Double check if everything is correct.

Now change the high fuse to `5D` (RSTDISBL programmed). If you did everything correctly, your Digispark should be functional now.

## Step 2, prepare dwire-debug

I did some improvement on dwire-debug and created a [release here](https://github.com/DeqingSun/dwire-debug/releases/tag/v0.1). 

If you are using Mac, you can download binary, add execute permission with `chmod +x dwdebug`, install libusb with `brew install libusb libusb-compat `.

For other OS, try to compile the source in the release. 

## Step 3, reprogram fuse on ATmega328p

Connect all wires and USB cable. run the following command in terminal to read fuse. If the avrdude on your computer locates in a different location, change the path accordingly.

`/Users/sundeqing/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino9/bin/avrdude -C/Users/sundeqing/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino9/etc/avrdude.conf -patmega328p -cusbtiny`

![read fuse](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/readFuse328.png)

Check if the signature and fuses are read correctly. 

If so, program new fuse values to enable debugWIRE and disable bootloader.

`/Users/sundeqing/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino9/bin/avrdude -C/Users/sundeqing/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino9/etc/avrdude.conf -patmega328p -cusbtiny -U lfuse:w:0xEF:m -U hfuse:w:0x9B:m -U efuse:w:0xFD:m`

![write fuse](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/writeFuse328.png)

Power cycle your board to make fuse change take effect.

## Step 4, check if dwire-debug is functional

In terminal, swtich to `dwdebug`'s location and run `./dwdebug device usbtiny1`. Check if ATmega328p can be connected. If so, press `Control+C` to terminate dwdebug.

![check debug](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/checkdwdebug.png)

## Step 5, install VScode and Arduino extension.

First download VScode from <https://code.visualstudio.com/>

![download VScode](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/downloadVScode.png)

Enable extensions side bar.

![Enable extensions](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/vscodeShowExtensions.png)

Look for Arduino extension (the offical one from Microsoft, not a random person) and install it.

![Install Arduino](https://github.com/DeqingSun/Debugging-Arduino-Uno/raw/master/img/vscodeInstallArduino.png)

Then you install Arduino extension. 

Click reload after you finish install.

![reload Arduino](https://github.com/DeqingSun/Debug-Debugging-Arduino-Uno/raw/master/img/vscodeReload.png)



  

