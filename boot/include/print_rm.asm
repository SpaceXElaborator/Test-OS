; begin the print call
print_rm:
	pusha

print_rm_begin:
	; move the base address into al
	mov al, [bx]
	; see if its zero, if equal jump to finish
	cmp al, 0
	je print_rm_finish

	; turn into TTY mode and use the print interrupt
	mov ah, 0x0e
	int 0x10

	; add one to the base address
	add bx, 1
	; loop again
	jmp print_rm_begin

; pop all the stuff back and then return
print_rm_finish:
	popa
	ret

; yeah just a newline
print_rm_newline:
	pusha

	mov ah, 0x0e
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10

	popa
	ret
