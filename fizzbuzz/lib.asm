strlen:
	mov rdx, rax
	
_strlen_loop:
	cmp byte [rdx], 0
	lea rdx, [rdx+1]
	jne _strlen_loop
	sub rdx, rax
	ret

print:
	push rax
	push rdi
	push rsi
	push rdx

	mov rsi, rax
	call strlen
	mov rax, 1    ; sys_write
	mov rdi, 1    ; stdout
	syscall	      ; x86-64 system call

	pop rdx
	pop rsi
	pop rdi
	pop rax
	ret

println:
	call print
	push rax
	push 0xA
	mov rax, rsp
	call print

	pop rax
	pop rax
	ret

exit:
	mov rax, 60
	mov rdi, 0
	syscall

