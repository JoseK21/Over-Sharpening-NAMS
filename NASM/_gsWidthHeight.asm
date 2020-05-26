section .data
    msg_width db "Width : "  
    len_msg_width equ 8

    msg_height db "Height : "
    len_msg_height equ 9

section .bss     
    width resb 10 
    height resb 10 

section .text 
    global _start_GS_WH

_start_GS_WH:  

_getWidth:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_width
    mov rdx, len_msg_width
    syscall
    ret

_setWidth:
    mov rax, 0 ; Input sys_read
    mov rdi, 0
    mov rsi, width
    mov rdx, 5
    syscall
    ret

_getHeight:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_height
    mov rdx, len_msg_height
    syscall
    ret

_setHeight:
    mov rax, 0 ; Input sys_read
    mov rdi, 0
    mov rsi, height
    mov rdx, 4 ; Posible to change to 5
    syscall
    ret
