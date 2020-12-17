section .data
maxlen: equ 1024
prompt: db "Enter your name (max 1024 characters): ", 0
result: db "Nice to meet you, ", 0

section .bss
buffer: resb maxlen

section .text
global _start
_start:
	mov rax, prompt
	call print

	mov rax, 0
	mov rdi, 0
	mov rsi, buffer
	mov rdx, maxlen
	syscall

	mov rax, result
	call print
	mov rax, buffer
	call print
	jmp exit

strlen:
	mov rbx, rax

strlen_loop:
	cmp byte[rbx], 0
	je strlen_stop
	inc rbx
	jmp strlen_loop

strlen_stop:
	sub rbx, rax
	ret

print:
	push rax
	push rbx
	push rdi
	push rsi
	push rdx

	call strlen
	mov rsi, rax
	mov rdx, rbx
	mov rax, 1
	mov rdi, 1
	syscall

	pop rdx
	pop rsi
	pop rdi
	pop rbx
	pop rax
	
	ret

exit:
	mov rax, 60
	mov rdi, 0
	syscall
