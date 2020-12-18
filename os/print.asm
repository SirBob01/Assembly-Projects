; Print subroutine
print:
    push ax
    push bx
    mov ah, 0x0e
_print_loop:
    cmp byte[bx], 0
    je _print_stop
    mov al, byte[bx]
    int 0x10
    inc bx
    jmp _print_loop
_print_stop:
    pop ax
    pop bx
    ret

; Print subroutine with newline (and carriage return)
println:
    call print
    push ax
    
    mov ah, 0x0e
    mov al, 0xd
    int 0x10
    mov al, 0xa
    int 0x10
    
    pop ax
    ret