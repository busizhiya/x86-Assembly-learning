#!/bin/sh
/opt/nasm-2.15.05/nasm $ASM_PATH/$ASM_PATH.asm -f bin -o $ASM_PATH/$ASM_PATH.bin -l $ASM_PATH/$ASM_PATH.lst
cp Template.vhd $ASM_PATH/$ASM_PATH.vhd
python3 bintovhd.py $ASM_PATH/$ASM_PATH.vhd $ASM_PATH/$ASM_PATH.bin
