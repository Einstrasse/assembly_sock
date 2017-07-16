section .data
msg:	db "Hello World", 0xa, 0

section .text
global _start
_start:
	mov rax, 1		;write syscall
	mov rdi, 0x1	;stdout
	mov rsi, msg 	;message
	mov edx, 15 	;length
	syscall

	mov rax, 60 	;exit
	syscall