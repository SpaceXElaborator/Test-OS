; linker will move to 7e00 for us
jmp Protected_Mode_Start

%include "include/gdt.asm"
%include "include/print_rm.asm"

Protected_Mode_Start:
	mov bx, STARTED_CM_JUMP
	call print_rm
	call EnableA20
	cli ; halt interrupts
	lgdt [gdt_descriptor] ; load our gdt to get into Compatibility mode
	mov eax, cr0
	or eax, 0x1 ; set 32bit mode in cr0
	mov cr0, eax
	jmp CODE_SEG:Protected_Mode_Run ; Far jump into 32bit mode

; Making sure that we turn on the 23st bit on an address bus.
; To eventually switch to 64bit mode
EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

[bits 32]
%include "32bit_include/print_cm.asm"
%include "32bit_include/cpuid.asm"
%include "32bit_include/paging.asm"

Protected_Mode_Run:
	; make sure that we have CPUID
	call DetectCPUID
	; make sure that we can even enter long mode
	call DetectLongMode

	; turn on paging
	call Paging_Setup

	; edit our GDT to 64bit mode
	call GDT_Edit

	jmp CODE_SEG:Long_Mode_Run ; Far jump into 64bit protected mode

[bits 64]
[extern _start]
Long_Mode_Run:
	mov edi, 0xb8000
	mov rax, 0x1f201f201f201f20
	mov ecx, 500
	rep stosq

	;call _start
	hlt

STARTED_CM_JUMP: db "Attempting to load into 32bit", 0
FINISHED_CM_JUMP: db "Jumped into 32bit CM Mode", 0
STARTED_LM_JUMP: db "Attempting to load into 64bit", 0

times 2048-($-$$) db 0 ; we have more space!
