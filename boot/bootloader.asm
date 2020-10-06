[org 0x7c00]
xor ax, ax
mov es, ax
mov ss, ax
mov ds, ax
jmp 0:csloaded
csloaded:

mov sp, 0x7c00
sti

mov bx, ReadingDisk
call print_rm
call print_rm_newline

mov [DRIVE_NUM], dl

call READ_DISK

jmp PRO_SPA

%include "include/print_rm.asm"
%include "include/disk.asm"

ReadingDisk: db "Setting up drives", 0

times 510-($-$$) db 0
dw 0xAA55
