; OS bootloader
; Assemble with nasm boot.asm -f bin
; Load with qemu-system-x86_64 boot
%define bootloader_offset 0x7c00
%define magic_number 0xaa55

[org bootloader_offset]
section .text
global _start
_start:
	mov bx, t1
	call println
	mov bx, t2
	call println
	jmp loop



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

; Main loop to prevent buffer overflows
loop:
	jmp loop

t1: db "Hello, world!", 0
t2: db "Reading disk...", 0
times 510 - ($-$$) db 0
dw magic_number
