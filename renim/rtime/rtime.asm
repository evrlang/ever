	.file	"rtime.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "RTIME\0"
	.text
	.globl	consoleWrite
	.def	consoleWrite;	.scl	2;	.type	32;	.endef
	.seh_proc	consoleWrite
consoleWrite:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	leaq	.LC0(%rip), %rdx
	movq	16(%rbp), %rax
	movl	$0, %r9d
	movq	%rdx, %r8
	movq	%rax, %rdx
	movl	$0, %ecx
	movq	__imp_MessageBoxA(%rip), %rax
	call	*%rax
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev4, Built by MSYS2 project) 16.2.0"
