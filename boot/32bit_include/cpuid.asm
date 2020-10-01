DetectCPUID:
	pushfd ; push flags onto the stack
	pop eax ; pop the value into eax

	mov ecx, eax ; move eax into ecx to use it later
	xor eax, 1 << 21 ; flip the bit
	push eax ; push back to stack
	popfd ; push it back to the stack

	; now check to see if the bit stayed flipped
	pushfd
	pop eax

	push ecx
	popfd

	xor eax, ecx
	jz NoCPUID
	ret

DetectLongMode:
	mov eax, 0x80000001
	cpuid
	test edx, 1 << 29
	jz NoLongMode
	ret

NoLongMode:
	hlt ; No long mode support

NoCPUID:
	hlt ; no CPUID Support
