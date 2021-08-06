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
dw 0xAA55