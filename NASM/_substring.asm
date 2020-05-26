section .data 
    file_name_sharpening db "../Image/image.txt", 0
    file_name_over_sharpening db "../Image/image.txt", 0

    file_name_image_sharpening db "../FilteredImages/ImageSharperning.txt", 0
    file_name_image_over_sharpening db "../FilteredImages/ImageOverSharperning.txt", 0

    
section .bss
    read_data resb 10

section .text
     global _start_substring

_start_substring:
_readBytes:
    mov rax, SYS_OPEN
    mov rdi, file_name_sharpening
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    push    rax
    mov     rdi, rax
    mov     rax, SYS_LSEEK
    mov     rsi, r15 ; <r15> Caracter Inicial
    mov     rdx, 0
    syscall
    
    mov rax, SYS_READ
    mov rsi, read_data
    mov rdx, 3 ; Cuantos tomo, a partir de r15
    syscall

    mov rax, SYS_CLOSE
    pop rdi
    syscall 

    ret


_readBytes_Over_Sharpening:
    mov rax, SYS_OPEN
    mov rdi, file_name_over_sharpening
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    push    rax
    mov     rdi, rax
    mov     rax, SYS_LSEEK
    mov     rsi, r15 ; <r15> Caracter Inicial
    mov     rdx, 0
    syscall
    
    mov rax, SYS_READ
    mov rsi, read_data
    mov rdx, 3 
    syscall

    mov rax, SYS_CLOSE
    pop rdi
    syscall 

    ret

_deleteFile:   
    mov eax, 10        ; system call 10: unlink
    mov ebx, file_name_image_sharpening ; file name to unlink
    int 80h            ; call into the system

    mov eax, 10        ; system call 10: unlink
    mov ebx, file_name_image_over_sharpening ; file name to unlink
    int 80h            ; call into the system

    ret