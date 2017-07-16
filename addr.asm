	.file	"addr.c"
	.section	.rodata
.LC0:
	.string	"13.124.75.20"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, -4(%rbp)
	movw	$2, -32(%rbp)
	leaq	.LC0(%rip), %rdi
	call	inet_addr@PLT
	movl	%eax, -28(%rbp)
	movl	$1337, %edi
	call	htons@PLT
	movw	%ax, -30(%rbp)
	movl	$16, -8(%rbp)
	movl	-8(%rbp), %edx
	leaq	-32(%rbp), %rcx
	movl	-4(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	connect@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-12) 6.3.0 20170406"
	.section	.note.GNU-stack,"",@progbits
