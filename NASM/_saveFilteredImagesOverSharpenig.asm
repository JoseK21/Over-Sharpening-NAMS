section .data
    filenameImageOverSharpening db "../FilteredImages/ImageOverSharperning.txt", 0

section .text
    global _startSFImagesOverSharpening

_startSFImagesOverSharpening:   

    ; CREATE FILE
    mov rax, SYS_OPEN
    mov rdi, filenameImageOverSharpening
    mov rsi, 0x441   ; O_CREAT| O _WRONLY | O_APPEND ;
    mov rdx, 0644o
    syscall

    ; WRITE FILE
    push rax
    mov rdi, rax 
    mov rax, SYS_WRITE
         
    mov rsi, number 
    mov rdx, 4
    syscall

    mov rax, SYS_CLOSE
    pop rdi
    syscall

    ret
