section .text
    global _startITO

_startITO:
; INTEGER TO STRING---------------
itoa:
	mov ebx, 0xCCCCCCCD             
	xor rdi, rdi
.loop:
	mov ecx, eax                    ; save original number

	mul ebx                         ; divide by 10 using agner fog's 'magic number'
	shr edx, 3                      ;

	mov eax, edx                    ; store it back into eax

	lea edx, [edx*4 + edx]          ; multiply by 10
	lea edx, [edx*2 - '0']          ; and ascii it
	sub ecx, edx                    ; subtract from original number to get remainder

	shl rdi, 8                      ; shift in to least significant byte
	or rdi, rcx                     ;

	test eax, eax
	jnz .loop   
	ret
; --------------------------------

