section .text
    global _startSTI

_startSTI:

atoi:
    xor rax, rax 

.top:
    movzx rcx, byte [rdx] 
    inc rdx 
    cmp rcx, '0'  
    jb .done
    cmp rcx, '9'
    ja .done
    sub rcx, '0'  
    imul rax, 10  
    add rax, rcx  
    jmp .top  
.done:
    ret