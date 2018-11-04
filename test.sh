#!/bin/bash
avrdudePath='/Users/sundeqing/Library/Arduino15/packages/arduino/tools/avrdude/6.3.0-arduino9'

#$avrdudePath/bin/avrdude -C$avrdudePath/etc/avrdude.conf  help
#check fuse (#default (E:FD, H:DA, L:FF))
$avrdudePath/bin/avrdude -C$avrdudePath/etc/avrdude.conf -patmega328p -cusbtiny 

#set fuse to fastboot, no bootloader, Debugwire Enable
$avrdudePath/bin/avrdude -C$avrdudePath/etc/avrdude.conf -patmega328p -cusbtiny -U lfuse:w:0xEF:m -U hfuse:w:0x9B:m -U efuse:w:0xFD:m