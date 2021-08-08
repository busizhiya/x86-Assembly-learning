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
	mov bx,cx
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

	

	
