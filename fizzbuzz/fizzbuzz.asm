; FizzBuzz itoa algorithm
; Reserve 16 bytes (digits in string) for variable str
; 

%include 'lib.asm'

section .data
fizz db "Fizz! ", 0
buzz db "Buzz! ", 0

section .bss
str: resb 16

section .text
global _start

_start:
	; Print Fizz!Buzz!
	mov rax, fizz
	call print
	mov rax, buzz
	call println

	; Set up the main counter
	mov rbx, 0

loop:	
	; Main program loop
	cmp rbx, 150
	je exit
	add rbx, 1
	
	xor rdx, rdx
	mov rax, rbx
	mov rcx, 15
	div rcx
	cmp rdx, 0
	je loop_print_fizzbuzz

	; rbx % 3 == 0
	xor rdx, rdx
	mov rax, rbx
	mov rcx, 3
	div rcx
	cmp rdx, 0
	je loop_print_fizz
	
	; rbx % 5 == 0
	xor rdx, rdx
	mov rax, rbx
	mov rcx, 5
	div rcx
	cmp rdx, 0
	je loop_print_buzz

	; else,
	jmp loop_print_num

loop_print_fizz:
	mov rax, fizz
	call println
	jmp loop

loop_print_buzz:
	mov rax, buzz
	call println
	jmp loop

loop_print_fizzbuzz:
	mov rax, fizz
	call print
	mov rax, buzz
	call println
	jmp loop	

loop_print_num:
	mov rax, rbx
	call itoa
	mov rax, str
	call println
	jmp loop	

itoa:
	push rax
	push rbx
	push rcx
	push rdx
	mov rcx, 0
	
_itoa_digits:
	; Fill the string with digits
	cmp rax, 0
	je _itoa_reverse
	
	mov rbx, 10
	xor rdx, rdx
	div rbx

	mov rbx, rdx	
	add rbx, '0'
	mov byte [str + rcx], bl
	add rcx, 1
	jmp _itoa_digits

_itoa_reverse:
	mov byte [str + rcx], 0 ; Null terminator
	sub rcx, 1

_itoa_reverse_loop:
	cmp rax, rcx
	jge _itoa_stop
	
	; Swap str[rax] and str[rcx]	
	mov bl, byte [str + rax]
	mov dl, byte [str + rcx]
	mov byte [str + rax], dl
	mov byte [str + rcx], bl

	add rax, 1
	sub rcx, 1
	jmp _itoa_reverse_loop

_itoa_stop:
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

