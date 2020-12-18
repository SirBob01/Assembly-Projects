; OS bootloader
; Assemble with nasm boot.asm -f bin
; Load with qemu-system-x86_64 boot
%define bootloader_offset 0x7c00
%define magic_number 0xaa55

[org bootloader_offset]

_start:
    mov bx, t1
    call println
    mov bx, t2
    call println
    jmp loop

; Main loop to prevent buffer overflows
loop:
    jmp loop

%include 'print.asm'

t1: db "Hello, world!", 0
t2: db "Reading disk...", 0
times 510 - ($-$$) db 0
dw magic_number
