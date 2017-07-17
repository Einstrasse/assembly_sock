	.file	"loop.c"
	.section	.rodata
.LC0:
	.string	"abcdefghi"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jne	.L2
	movl	$5, -12(%rbp)
	jmp	.L3
.L2:
	cmpl	$1, -12(%rbp)
	jne	.L4
	movl	$4, -12(%rbp)
	jmp	.L3
.L4:
	cmpl	$2, -12(%rbp)
	jne	.L3
	movl	$3, -12(%rbp)
.L3:
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-12) 6.3.0 20170406"
	.section	.note.GNU-stack,"",@progbits
