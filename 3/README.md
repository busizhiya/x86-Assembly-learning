# Print number on screen

## Description:

​	此程序用于在显示器上输出我们所指定标号相对于当前段的偏移地址

​	对应原书中第五章的内容

## Goal:

​	以十进制的方式输出,

​	div指令、xor指令

​	jmp相对近转移无限循环

​	标号,汇编地址的妙用

​	数据段的开辟与使用

## Code:

```assembly
mov ax,0xB800
mov es,ax;设置显存段段es中

;输出offset:到屏幕上
mov byte [es:0x00],'o'
mov byte [es:0x01],0x07

mov byte [es:0x02],'f'
mov byte [es:0x03],0x07

mov byte [es:0x04],'f'
mov byte [es:0x05],0x07

mov byte [es:0x06],'s'
mov byte [es:0x07],0x07

mov byte [es:0x08],'e'
mov byte [es:0x09],0x07

mov byte [es:0x0a],'t'
mov byte [es:0x0b],0x07

mov byte [es:0x0c],':'
mov byte [es:0x0d],0x07

mov ax,cs
mov ds,ax;从现在开始,程序的代码段就加载到ds数据段了

offset: mov ax,offset;随便取一个offset,就以当前这条指令的汇编地址位offset吧~
mov bx,10;除数位10,存在bl中

;计算
xor dx,dx;dx清零
div bx;16位除法
mov [0x7c00+data+0x00],dl;65535%10<10,直接用dl就可以啦

xor dx,dx
div bx
mov [0x7c00+data+0x01],dl;		十位

xor dx,dx
div bx
mov [0x7c00+data+0x02],dl;		百位

xor dx,dx
div bx
mov [0x7c00+data+0x03],dl;		千位

xor dx,dx
div bx
mov [0x7c00+data+0x04],dl;		万位


;输出
mov al,[0x7c00+data+0x04]
add al,'0'
mov [es:0x0e],al
mov byte [es:0x0f],0_111_0_100B

mov al,[0x7c00+data+0x03]
add al,'0'
mov [es:0x0e],al
mov byte [es:0x0f],0_111_0_100B

mov al,[0x7c00+data+0x02]
add al,'0'
mov [es:0x10],al
mov byte [es:0x11],0_111_0_100B

mov al,[0x7c00+data+0x01]
add al,'0'
mov [es:0x12],al
mov byte [es:0x13],0_111_0_100B

mov al,[0x7c00+data+0x00]
add al,'0'
mov [es:0x14],al
mov byte [es:0x15],0_111_0_100B

;无限循环
inf:jmp near inf

data:
	times 5 db 0;开辟5个bytes的空间存数字

times 510-($-$$) db 0;填补0
dw 0xAA55;新学会的dw~
```

## Show:

![截屏2021-08-06 下午1.13.02](https://tva1.sinaimg.cn/large/008i3skNly1gt6zrmmbtuj316b0u0jv6.jpg)

## Tricks:

1.记住,永远要小心不要让程序执行到你的数据段的内容!

2.养成好习惯,显式的指定操作数的宽度

3.标号很好用,要记住代表的是汇编地址

4.初始化后cs=ds=0x0000,ip=0x7c00,访问data使用ds[0x7c00+data+0x00]

​	或者,你可以修改ds为0x07c0,这样更方便~

5.可以用二进制的方式表示立即数,nasm还支持在每个bit之间添加_,这样就很容易区分不同的bit位啦!

## Todo:

也许我们不用这么节省,把数据段开辟到一个单独的地方吧!

loop减少代码冗余

## Warnings:

还是那句老话,记住,永远要小心不要让程序执行到你的数据段的内容,否则后果难以预料~~

