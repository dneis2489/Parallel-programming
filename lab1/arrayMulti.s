	.file	"arrayMulti.c"
	.text
	.globl	sse
	.type	sse, @function
sse:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
#APP
# 6 "arrayMulti.c" 1
	movups (%rax), %xmm0
movups (%rdx), %xmm1
mulps %xmm1, %xmm0
movups %xmm0, (%rcx)

# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sse, .-sse
	.globl	multiply_sequential
	.type	multiply_sequential, @function
multiply_sequential:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L3
.L4:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm1
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L3:
	cmpl	$3, -4(%rbp)
	jle	.L4
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	multiply_sequential, .-multiply_sequential
	.section	.rodata
.LC9:
	.string	"SSE Result: "
.LC10:
	.string	"%.2f "
.LC11:
	.string	"\nSequential Result: "
.LC12:
	.string	"\nSSE: %.6f seconds\n"
	.align 8
.LC13:
	.string	"\320\237\321\200\320\276\321\201\321\202\320\276\320\265 \321\203\320\274\320\275\320\276\320\266\320\265\320\275\320\270\320\265: %.6f seconds\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -116(%rbp)
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -80(%rbp)
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -76(%rbp)
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -72(%rbp)
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -68(%rbp)
	movss	.LC4(%rip), %xmm0
	movss	%xmm0, -64(%rbp)
	movss	.LC5(%rip), %xmm0
	movss	%xmm0, -60(%rbp)
	movss	.LC6(%rip), %xmm0
	movss	%xmm0, -56(%rbp)
	movss	.LC7(%rip), %xmm0
	movss	%xmm0, -52(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	call	clock@PLT
	movq	%rax, -112(%rbp)
	movl	$0, -132(%rbp)
	jmp	.L6
.L7:
	leaq	-48(%rbp), %rdx
	leaq	-64(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	sse
	addl	$1, -132(%rbp)
.L6:
	movl	-132(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jl	.L7
	call	clock@PLT
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	subq	-112(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC8(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -96(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	call	clock@PLT
	movq	%rax, -112(%rbp)
	movl	$0, -128(%rbp)
	jmp	.L8
.L9:
	leaq	-32(%rbp), %rdx
	leaq	-64(%rbp), %rcx
	leaq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	multiply_sequential
	addl	$1, -128(%rbp)
.L8:
	movl	-128(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jl	.L9
	call	clock@PLT
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	subq	-112(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC8(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -88(%rbp)
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -124(%rbp)
	jmp	.L10
.L11:
	movl	-124(%rbp), %eax
	cltq
	movss	-48(%rbp,%rax,4), %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	addl	$1, -124(%rbp)
.L10:
	cmpl	$3, -124(%rbp)
	jle	.L11
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -120(%rbp)
	jmp	.L12
.L13:
	movl	-120(%rbp), %eax
	cltq
	movss	-32(%rbp,%rax,4), %xmm0
	pxor	%xmm3, %xmm3
	cvtss2sd	%xmm0, %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	addl	$1, -120(%rbp)
.L12:
	cmpl	$3, -120(%rbp)
	jle	.L13
	movq	-96(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1065353216
	.align 4
.LC1:
	.long	1073741824
	.align 4
.LC2:
	.long	1077936128
	.align 4
.LC3:
	.long	1082130432
	.align 4
.LC4:
	.long	1084227584
	.align 4
.LC5:
	.long	1086324736
	.align 4
.LC6:
	.long	1088421888
	.align 4
.LC7:
	.long	1090519040
	.align 8
.LC8:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
