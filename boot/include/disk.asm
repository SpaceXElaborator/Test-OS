PRO_SPA equ 0x8000
READ_DISK:
	pusha
	xor ax, ax
	xor dx, dx
	xor bx, bx

	.Start:
		mov dl, byte [DRIVE_NUM]
		mov ah, 0x42
		mov si, DiskAddressPacket
		int 13h
		jnc .Done

		mov bx, FAILED
		call print_rm

		cli
		hlt
	.Done:
		mov bx, SUCCESS
		call print_rm
		call print_rm_newline
	popa
ret

DiskAddressPacket:
	.Size: db 0x10
	.Unused: db 0x0
	.SectorsToRead: dw 0x0002
	.Offset:	dw 0x7e00
	.Segment:	dw 0x0
	.LBA:		dq 1


DRIVE_NUM: db 0x80
SUCCESS: db "Read Drive Successfully", 0
FAILED: db "Could Not Read Drive...", 0
