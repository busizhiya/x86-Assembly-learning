# Helloworld

## Description:

此程序用于在显示器上实现输出“Hello World”效果的文字

练习显存文字模式下的操作

## Code:

```assembly
start:
	mov ax,0xB800
	mov ds,ax
	;mov ds,0xB800	错误的!

	mov byte [0x00],'H'
	mov byte [0x01],0b10001001

	mov byte [0x02],'e'
	mov byte [0x03],0b10001001

	mov byte [0x04],'l'
	mov byte [0x05],0b10001001

	mov byte [0x06],'l'
	mov byte [0x07],0b10001001

	mov byte [0x08],'o'
	mov byte [0x09],0b10001001

	mov byte [0x0a],' '
	mov byte [0x0b],0b00000000

	mov byte [0x0c],'W'
	mov byte [0x0d],0b10001001

	mov byte [0x0e],'o'
	mov byte [0x0f],0b10001001

	mov byte [0x10],'r'
	mov byte [0x11],0b10001001

	mov byte [0x12],'l'
	mov byte [0x13],0b10001001

	mov byte [0x14],'d'
	mov byte [0x15],0b10001001

	jmp 0x0000:0x7c00  ; jmp start
current:
	times 510-(current-start) db 0 ; 或 510-($-$$)
	db 0x55,0xAA
```



## Show:

![截屏2021-08-05 下午10.28.37](/Users/qiao/Desktop/截屏2021-08-05 下午10.28.37.png)

## Tricks:

1.8086下显示器文字模式的显存范围为0xB800~0xBFFF

2.不可以直接把立即数转移到寄存器中,要先通过通用寄存器中介

3.mov指令指定宽度,因为内存地址和立即数都很模糊,不能确定是字传送还是字节传送

4.time 510-($-$$) db 0

​			`	$`的意思是“这里的地址”。

​			`$$`的意思是“当前部分的开头地址”。

​			所以`$-$$`的意思是“当前大小的部分”。	

5.db 可以有多个值,代表同时开辟多个值 e.g.    db 0x55,0xAA

6.显存属性Cheatsheet请查看学习笔记

## Todo:

使用loop减少冗余代码

## Warnings:

注意,在使用bochs虚拟机调试时,遇到有关显存的操作时,使用`s`进行单步调试是不会修改显存的,应该使用`n`命令