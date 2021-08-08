# Calulate the sum of 1 to 1000

## Description:

此程序用于计算1到1000的和

对应原书第七章的章节练习2

## Goal:

使用adc进行进位

## Code:

```assembly
jmp near start

text: 
	db 'Hi,this is the sum of 1 to 1000:'
start:
	;数据段初始化
	mov ax,0x07c0
	mov ds,ax
	mov si,text

	;显存段初始化
	mov ax,0xB800
	mov es,ax
	xor di,di

	mov cx,start-text
title:
	movsb
	mov byte [es:di],0x07;写入属性
	inc di
	
	loop title

	mov cx,1000
	xor ax,ax;用ax记录结果
	xor dx,dx
sum:
	add ax,cx
	adc dx,0x0000;使用dx储存超出的值
	loop sum

	;栈段初始化
	mov ss,cx
	mov sp,cx

	;计算
	mov bx,10;除数
	xor cx,cx
	
calc:
	inc cx;记录位数
	div bx;除法
	or dl,0x30;加上'0'
	push dx;放入栈中
	xor dx,dx;将dx(余数)清零
	cmp ax,0
	jne calc

show:
	pop bx
	mov byte bh,0b01110100
	mov word [es:di],bx
	add di,2
	loop show

	jmp near $
times 510-($-$$) db 0
dw 0xAA55
```

## Show:

![截屏2021-08-08 上午11.51.20](https://tva1.sinaimg.cn/large/008i3skNly1gt98n4zqemj316b0u0q6n.jpg)

## Tricks:

1.adc可以在计算时加上CF标志位进行计算

## Todo:

~~拓展到1到1000的和~~

## Warnings:

在进行16位除法时,就算要用到dx寄存器的内容参与计算,也要记得在div指令后使用将dx置为0,不然剩余的余数会被当作高16位参与下一次的运算.