section .data
msg:	db "Hello World", 0xa, 0

section .text
global _start
_start:
	mov rax, 1
	mov rdi, 0x1
	mov rsi, msg
	mov edx, 15
	syscall

	mov rax, 60
	syscall