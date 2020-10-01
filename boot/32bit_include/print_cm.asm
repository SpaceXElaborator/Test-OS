[bits 32]
VID_MEM equ 0xb8000 ; variable for video memory and where the cursor is
W_O_B equ 0x0f ; white (f) on black (0)

print_cm:
	pusha
	mov edx, VID_MEM

; same thing as 16 bit print loop
print_cm_loop:
	mov al, [ebx]
	mov ah, W_O_B

	cmp al, 0
	je print_cm_done

	; add both our color byte and character byte
	mov [edx], ax
	add ebx, 1
	add edx, 2

	jmp print_cm_loop

print_cm_done:
	popa
	ret
