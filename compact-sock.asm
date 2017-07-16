	.file	"compact-sock.c"
	.comm	buf_get,255,32
	.comm	reverse,255,32
	.comm	len,4,4
	.text
	.globl	rev
	.type	rev, @function
rev:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	len(%rip), %eax
	subl	$1, %eax
	subl	-4(%rbp), %eax
	movslq	%eax, %rdx
	leaq	buf_get(%rip), %rax
	movzbl	(%rdx,%rax), %ecx
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	leaq	reverse(%rip), %rax
	movb	%cl, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L2:
	movl	len(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L3
	movl	len(%rip), %eax
	movslq	%eax, %rdx
	leaq	reverse(%rip), %rax
	movb	$0, (%rdx,%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	rev, .-rev
	.section	.rodata
.LC0:
	.string	"13.124.75.20"
.LC1:
	.string	"Connect ereror: "
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$288, %rsp
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, -12(%rbp)
	movw	$2, -288(%rbp)
	leaq	.LC0(%rip), %rdi
	call	inet_addr@PLT
	movl	%eax, -284(%rbp)
	movl	$1337, %edi
	call	htons@PLT
	movw	%ax, -286(%rbp)
	movl	$16, -16(%rbp)
	movl	-16(%rbp), %edx
	leaq	-288(%rbp), %rcx
	movl	-12(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	connect@PLT
	testl	%eax, %eax
	jns	.L5
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
	movl	$0, %edi
	call	exit@PLT
.L5:
	movl	-12(%rbp), %eax
	movl	$255, %edx
	leaq	buf_get(%rip), %rsi
	movl	%eax, %edi
	call	read@PLT
	movl	$0, -4(%rbp)
	jmp	.L6
.L9:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	leaq	buf_get(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	cmpb	$10, %al
	jne	.L7
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	leaq	buf_get(%rip), %rax
	movb	$0, (%rdx,%rax)
	movl	-4(%rbp), %eax
	movl	%eax, len(%rip)
	jmp	.L8
.L7:
	addl	$1, -4(%rbp)
.L6:
	cmpl	$254, -4(%rbp)
	jle	.L9
.L8:
	leaq	buf_get(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	call	rev
	leaq	reverse(%rip), %rdi
	call	puts@PLT
	movl	len(%rip), %eax
	movslq	%eax, %rdx
	leaq	reverse(%rip), %rax
	movb	$10, (%rdx,%rax)
	movl	-12(%rbp), %eax
	movl	$255, %edx
	leaq	reverse(%rip), %rsi
	movl	%eax, %edi
	call	write@PLT
	movl	-12(%rbp), %eax
	movl	$255, %edx
	leaq	buf_get(%rip), %rsi
	movl	%eax, %edi
	call	read@PLT
	movl	$0, -8(%rbp)
	jmp	.L10
.L13:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	leaq	buf_get(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	cmpb	$10, %al
	jne	.L11
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	leaq	buf_get(%rip), %rax
	movb	$0, (%rdx,%rax)
	movl	-8(%rbp), %eax
	movl	%eax, len(%rip)
	jmp	.L12
.L11:
	addl	$1, -8(%rbp)
.L10:
	cmpl	$254, -8(%rbp)
	jle	.L13
.L12:
	leaq	buf_get(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-12) 6.3.0 20170406"
	.section	.note.GNU-stack,"",@progbits
