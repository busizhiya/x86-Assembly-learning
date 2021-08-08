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

	

	
