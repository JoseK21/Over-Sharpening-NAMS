; add (-1 * #) = sub (1 * #)

_k1:
    ret

_k2:
    sub RBP, rax 
    ret

_k3:
    ret

_k4:
    sub RBP, rax 
    ret

_k5:
    mov RDI, 5
    mul RDI
    add RBP, rax ; 1:rax 
    ret

_k6:
    sub RBP, rax 
    ret

_k7:
    ret

_k8:
    sub RBP, rax 
    ret

_k9:
    mov r9, 0
    ret