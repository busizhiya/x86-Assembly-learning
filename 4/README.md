# Print number on screen with loop

## Description:

​	此程序实现的功能与实验三程序相同,不同之处在于本程序使用不同的循环、跳转对上一程序进行修改,使代码荣冗余更小

## Goal:

​		利用8086段表示灵活性,更改ds段基址,便捷使用汇编地址(标号)

​		`movsw`、`movsb`段传送指令,`cld`、`std`控制传送方向

​		有符号数&无符号数的概念

​		有符号数,**符号拓展**位宽`cbw`、`cwd`

​		寄存器状态标志位

​		`loop`,以cx计数的循环

​		`jcc`指令系列(跳转指令)

​		`dec	`、`inc`加1与减1

​		`cmp` 比较更改标志位;	`neg`取相反数

​		使用bochs调试指令`n`、`info` 

## Code:

```assembly
jmp near start;跳过数据段
;数据段
text:
	db 'H',0x07,'i',0x07,',',0x07,'l',0x07,'o',0x07,'o',0x07,'p',0x07,':',0x07
number:
	times 5 db 0
;代码段
start:
;准备段转移
	;重点
	mov word ax,0x7c0;记住了!为了简便操作,我们将段地址设为一开始的偏移地址
	

	mov word ds,ax;源

	mov word ax,0xB800
	mov word es,ax;目标

	mov word si,text;源偏移
	mov word di,0;目标偏移
	mov word cx,(number-text)/2;八个字
	cld;正向传送
	rep movsw;执行传送

	;计算
	mov word cx,5;一共五位数,0,1,2,3,4
	mov word ax,number;计算number偏移的十进制数字吧
	mov word si,10;除数
	mov word bx,number;计算后存在这里
calu:
	xor dx,dx;清零
	div si
	mov byte [bx],dl
	inc bx
	loop calu;循环回去

	mov word bx,number;恢复bx
	mov word si,4;偏移地址

show:
	mov byte al,[bx+si];获取当前数位
	add al,0x30;加上'0'
	mov byte ah,0b0_111_0_100;设置白底红色
	;因为小端字节序,所以字符的编码在低地址,在al,属性在高地址,在ah
	mov word [es:di],ax;因为没有改变过di,所以di还是最后输出的偏移地址
	add di,2;往后两位
	dec si;减一位,相当于向有移动一位
	;一定要记住,判断条件的更改操作要在循环体的末尾!不然其他运算操作会影响的!
	jns show;只要不是负数,就继续

	jmp near $;无限循环

times 510-($-$$) db 0
dw 0xAA55
```

## Show:

![截屏2021-08-07 下午5.15.01](https://tva1.sinaimg.cn/large/008i3skNly1gt8cdlz978j316b0u0djm.jpg)

## Tricks:



1.假如将数据段设置在代码段中,使用时记得将段基址设为0x07c0,这样使用汇编地址作为偏移地址才不会出错

2.只有bx,bp,si,di可以作为内存地址的变量寄存器

## Todo:

暂无

## Warnings:

1.在数据段前添加jmp指令避免执行数据段内容

2.要记得在段传送指令前使用cld或std指定方向,避免出错

3.在jcc系循环中,时刻注意管理变化的偏移量,并且一定要将影响标志位的运算放在最后

## 