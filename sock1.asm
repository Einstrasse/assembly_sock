global _start
_start:
	mov rbp, rsp
	sub rsp, 700
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
	syscall ;read. fetch packet data from server

	; mov rax, 1
	; mov rdi, 1
	; lea rsi, [rbp-300]
	; mov rdx, 255
	; syscall ;write. dump received data

	mov rcx, 0
	lea rdx, [rbp-300] ;initialization for calculate length of string
_cnt_loop:
	inc rcx
	cmp byte [rdx+rcx], 0xa
	jne _cnt_loop
	;add rcx, 1
	;mov byte [rdx+rcx], 0x0 ; termination with null
	;sub rcx, 1
	;get the length of received string. length is stored on rcx

	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-300]
	mov rdx, rcx; backup rcx value(strlen) to rdx register
	mov dword[rbp-604], ecx; store strlen
	add rcx, 1 ; to print new line character on stdout
	syscall ;write. dump received data

	mov rcx, rdx
	nop
	nop
	mov rbx, rcx
	sub rcx, 1 ; rev counting
	;shr rbx, 1 ; rbx-> threshold
	mov r8, 0 ; counting
	lea r11, [rbp-300]; [rbp-300] -> str
	lea r10, [rbp-600]; [rbp-600] -> rev

_rev_loop:
	mov byte dl, [r11+rcx]
	;mov byte r10, [rdx+r8]
	;xor r9, r10
	;xor r10, r9
	;xor r9, r10
	;mov byte [rdx+rcx], r9
	;mov byte [rdx+r8], r10
	mov [r10+r8], dl
	sub rcx, 1
	add r8, 1
	cmp qword r8, rbx
	jne _rev_loop
	mov byte [r10+r8], 0xa
	add r8, 1
	mov byte [r10+r8], 0x0

;;dump reversed for debugging
	mov rax, 1
	mov rdi, 1
	lea rsi, [rbp-600]
	;mov rdx, 255
	add dword [rbp-604], 1
	mov edx, [rbp-604]
	syscall ;write. dump received data; printf reversed on stdout
	nop
	nop
	nop
	nop
	nop



;db 0xcc