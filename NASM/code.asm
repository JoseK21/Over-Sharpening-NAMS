%include "linux64.inc"
%include "_gsWidthHeight.asm"
%include "_stringToInteger.asm"
%include "_integetToString.asm"
%include "_substring.asm"
%include "_operationsFilter.asm"
%include "_saveFilteredImages.asm"
%include "_saveFilteredImagesOverSharpenig.asm"
%include "_kernelSharpening.asm"
%include "_kernelOverSharpening.asm"

; CONSTANTS
section .data 
    newline db 10, 0

    max_dec equ 255
    min_dec equ 0

    add_0 equ "0"
    add_00 equ "00"
    add_000 equ "000"

    _10 equ 10
    _100 equ 100

    name dd 0

; VARIABLES
section .bss 
    number resb 3
    length_number resb 10

    width_number resb 10
    height_number resb 10

    total_pixels_number resb 10
    total_pixels_number_000 resb 10

    index_pos_number resb 10

; LOGIC
section .text 
    global _start

_start:  
    call _deleteFile
    
    call _getWidth
    call _setWidth
    call _getHeight
    call _setHeight

    mov rdx, width
    call atoi 
    mov r13, rax  
   
    mov rdx, height
    call atoi
    mov [height_number], rax

    call _getTotalPixels ; [total_pixels_number] : Total pixels
    call _getTotalPixels000 ; [total_pixels_number_000] : Total píxels with 000s
    call _getInitialPos  ; r15 : Initial Position

    mov r14, 1 ; r14 : contador pixels
    mov r10, 0 ; r10 : contador columnas - |OK|
    mov r9, 0 ; r9 : contador de celdas (9)

    ;jmp _loopPixel
    jmp _loopPixel_Over_Sharpening

; SHARPENING 
_loopPixel:
    mov r8, r15 ; pos edited to start
    call _getFriendsPixels ; get / show near pixels
    cmp r14, [total_pixels_number] ; [total_pixels_number] 
    jl _new_pixel
    ;je _reset
    exit

_new_pixel:
    INC r14  
    INC r10

    cmp r10, r13
    je _addTripleStep 
    jne _addSimpleStep

_addSimpleStep:    
    add r15, 3 
    call _loopPixel

_addTripleStep:
    mov r10, 0
    add r15, 9
    call _loopPixel

_getFriendsPixels:
    mov r15, r8
    
    XOR RBP, RBP
    mov RBP, 0
    mov RBP, 4000

    call _C1
    call _printPixel
    
    mov r15, r8
    call _C2
    call _printPixel
    
    mov r15, r8
    call _C3
    call _printPixel
    
    mov r15, r8
    call _C4
    call _printPixel
    
    mov r15, r8
    call _C5
    call _printPixel
    
    mov r15, r8
    call _C6
    call _printPixel
    
    mov r15, r8
    call _C7
    call _printPixel
    
    mov r15, r8
    call _C8
    call _printPixel
    
    mov r15, r8
    call _C9
    call _printPixel    
    
    mov r15, r8
    
    mov eax, EBP
    call itoa
    mov [number], rdi
    
    call _startSFImagesSharpening
    ret

_printPixel:
    call _readBytes

    mov rdx, read_data
    call atoi
      
    INC r9

    cmp r9, 1
    je _k1

    cmp r9, 2 
    je _k2

    cmp r9, 3 
    je _k3

    cmp r9, 4 
    je _k4

    cmp r9, 5 
    je _k5

    cmp r9, 6 
    je _k6

    cmp r9, 7 
    je _k7

    cmp r9, 8 
    je _k8

    cmp r9, 9
    je _k9

    ret


; OVER SHARPENING 

_reset:
    
    call _getTotalPixels ; [total_pixels_number] : Total pixels
    call _getTotalPixels000 ; [total_pixels_number_000] : Total píxels with 000s
    call _getInitialPos  ; r15 : Initial Position

    mov r14, 1 ; r14 : contador pixels
    mov r10, 0 ; r10 : contador columnas - |OK|
    mov r9, 0 ; r9 : contador de celdas (9)

    jmp _loopPixel
    ;jmp _loopPixel_Over_Sharpening


_loopPixel_Over_Sharpening:
    mov r8, r15 ; pos edited to start
    call _getFriendsPixels_Over_Sharpening ; get / show near pixels
    cmp r14, [total_pixels_number]
    jl _new_pixel_Over_Sharpening
    je _reset ;;;;

    exit

_new_pixel_Over_Sharpening:
    INC r14  
    INC r10

    cmp r10, r13
    je _addTripleStep_Over_Sharpening 
    jne _addSimpleStep_Over_Sharpening

_addSimpleStep_Over_Sharpening:    
    add r15, 3 
    call _loopPixel_Over_Sharpening

_addTripleStep_Over_Sharpening:
    mov r10, 0
    add r15, 9
    call _loopPixel_Over_Sharpening

_getFriendsPixels_Over_Sharpening:
    mov r15, r8
    
    XOR RBP, RBP
    mov RBP, 0
    mov RBP, 4000

    call _C1
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C2
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C3
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C4
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C5
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C6
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C7
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C8
    call _printPixel_Over_Sharpening
    
    mov r15, r8
    call _C9
    call _printPixel_Over_Sharpening 
    
    mov r15, r8
    
    mov eax, EBP
    call itoa
    mov [number], rdi
    
    call _startSFImagesOverSharpening
    ret

_printPixel_Over_Sharpening:
    call _readBytes_Over_Sharpening

    mov rdx, read_data
    call atoi
      
    INC r9

    cmp r9, 1
    je _k1_os

    cmp r9, 2 
    je _k2_os

    cmp r9, 3 
    je _k3_os

    cmp r9, 4 
    je _k4_os

    cmp r9, 5 
    je _k5_os

    cmp r9, 6 
    je _k6_os

    cmp r9, 7 
    je _k7_os

    cmp r9, 8 
    je _k8_os

    cmp r9, 9
    je _k9_os

    ret



; GENERALS

_getTotalPixels:
    mov rax, r13
    mov rbx, [height_number]
    mul rbx    
    mov [total_pixels_number], rax ; Total pixels to process
    ret

_getTotalPixels000:
    mov rax, r13
    add rax, 2
    mov rbx, [height_number]
    add rbx, 2
    mul rbx    
    mov [total_pixels_number_000], rax ; Total pixels to process with 000s
    ret

_getInitialPos:
    mov rax, r13
    add rax, 3
    mov rbx, 3
    mul rbx 
    mov r15, rax
    ret