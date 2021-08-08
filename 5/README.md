# Calulate the sum of 1 to 100

## Description:

此程序用于计算1到100的和

对应原书第七章的内容

## Goal:

使用`db ''`创建字符串

使用栈

bochs调试 `print-stack <num>`显示栈内容

更加熟悉8086的寻址方式

## Code:

```assembly
jmp near start

text: 
	db 'Hi,this is the sum of 1 to 100:'
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
	mov byte al,[si];取出数据
	mov ah,0x07
	inc si

	mov word [es:di],ax;写入数据
	add di,2
	
	loop title

	mov cx,100
	xor ax,ax;用ax记录结果
sum:
	add ax,cx
	loop sum

	;计算
	mov si,10;除数
	xor cx,cx

	;栈段初始化
	mov bx,cs
	mov ss,bx
	mov sp,bx
calc:
	inc cx;记录位数
	xor dx,dx;清空dx
	div si;除法
	add dl,0x30;加上'0'
	push dx;放入栈中

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

![截屏2021-08-08 上午10.52.55](https://tva1.sinaimg.cn/large/008i3skNly1gt96ycdm62j316b0u0adr.jpg)

## Tricks:

1.使用db ''创建字符串真是太方便啦~

2.在进行屏幕输出title的时候,本来想着用段传送指令,但奈何中间需要加上文字属性,而使用字符串又不能对其进行更改,只能退而求其次,使用loop

3.栈FILO的特性刚好符合我们显示数字的需求!!

## Todo:

拓展到1到1000的和

## Warnings:

1.对偏移指针进行操作时要想清楚,到底是+1还是+2

2.栈的push是先对指针-2,再传送值

pop是先传送值,再对指针+2

栈是反向增长的	

