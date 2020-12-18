; OS bootloader
; Assemble with nasm boot.asm -f bin
; Load with qemu-system-x86_64 boot
%define bootloader_offset 0x7c00
%define magic_number 0xaa55

[org bootloader_offset]
section .text
global _start
_start:
	call print
	jmp loop

print:
	mov bx, text
	mov ah, 0x0e
print_loop:
	cmp byte[bx], 0
	je print_stop
	mov al, byte[bx]
	int 0x10
	inc bx
	jmp print_loop
	
print_stop:
	ret

loop:
	jmp loop

text: db "Hello, world", 0
times 510 - ($-$$) db 0
dw magic_number
