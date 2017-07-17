global _start
_start:
	mov rbp, rsp
	sub rsp, 700
	mov rax, 41
	mov edx, 0
	mov esi, 1
	mov edi, 2
	syscall ; socket function

	mov [rbp], rax; var [rbp] -> fd
	mov dword [rbp-20], 0x39050002
	mov dword [rbp-16], 0x144b7c0d
	mov dword [rbp-12], 0x55554660
	mov dword [rbp-8], 0x00005555
	mov rax, 42
	mov rdi, [rbp] ;maybe 3
	lea rsi, [rbp-20] ; var [rbp-20] -> clientaddr
	mov rdx, 16
	syscall ;connect

	mov rax, 0
	mov rdi, [rbp]
	lea rsi, [rbp-300]; var [rbp-300] -> read buffer
	mov rdx, 255
	syscall ;read. fetch packet data from server


	mov rcx, 0
	lea rdx, [rbp-300] ;initialization for calculate length of string
_cnt_loop:
	inc rcx
	cmp byte [rdx+rcx], 0xa
	jne _cnt_loop

	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-300]
	mov rdx, rcx; backup rcx value(strlen) to rdx register
	mov dword[rbp-604], ecx; var [rbp-604] -> strlen
	add rcx, 1 ; to print new line character on stdout
	syscall ;write. (printf received message)

	mov rcx, rdx
	nop
	nop
	mov rbx, rcx; rbx -> threshold
	sub rcx, 1 ; rev counting
	mov r8, 0 ; writing offset
	lea r11, [rbp-300]; var [rbp-300] -> str
	lea r10, [rbp-600]; var [rbp-600] -> rev

_rev_loop: ;reversely copy string
	mov byte dl, [r11+rcx]
	mov [r10+r8], dl
	sub rcx, 1
	add r8, 1
	cmp qword r8, rbx
	jne _rev_loop

	mov byte [r10+r8], 0xa ; terminate with \r
	add r8, 1
	mov byte [r10+r8], 0x0 ; terminate with \0

	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-600]
	;mov rdx, 255
	add dword [rbp-604], 1
	mov edx, [rbp-604]
	syscall ;write. (printf reversed string)

	mov rax, 1
	mov dword edi, [rbp]
	lea rsi, [rbp-600]
	add dword [rbp-604], 1
	mov edx, [rbp-604]
	syscall ;write. send reversed string to server

	mov rax, 0
	mov rdi, [rbp]
	lea rsi, [rbp-300]; [rbp-300] -> read buffer
	mov rdx, 255
	syscall ;read. fetch final data from server

	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-300]
	mov edx, 0x3
	syscall ;write. dump final message

	mov rax, 60
	mov rdi, 1
	syscall;;exit process
