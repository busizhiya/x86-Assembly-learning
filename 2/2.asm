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
	times 510-(current-start) db 0   ; 或 510-($-$$)
	db 0x55,0xAA
