
section .text 
    global _start_OF

_start_OF:

_C1:
	sub r15, r13
	sub r15, r13
	sub r15, r13
	sub r15, 9
	ret

_C2:
	sub r15, r13
	sub r15, r13
	sub r15, r13
	sub r15, 6
	ret

_C3:
	sub r15, r13
	sub r15, r13
	sub r15, r13
	sub r15, 3
	ret

_C4:
	sub r15, 3
	ret

_C5:
	sub r15, 0
	ret

_C6:
	add r15, 3
	ret

_C7:
	add r15, r13
	add r15, r13
	add r15, r13
	add r15, 3
	ret

_C8:
	add r15, r13
	add r15, r13
	add r15, r13
	add r15, 6
	ret

_C9:
	add r15, r13
	add r15, r13
	add r15, r13
	add r15, 9
	ret
	