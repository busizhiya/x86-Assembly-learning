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

