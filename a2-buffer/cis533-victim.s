	.file	"cis533-victim.c"
	.section	.rodata
.LC0:
	.string	"&main = %p\n"
.LC1:
	.string	"&shell = %p\n"
.LC2:
	.string	"&inputs[0] = %p\n"
.LC3:
	.string	"&buf[0] = %p\n"
.LC4:
	.string	"BEFORE picture of stack\n"
.LC5:
	.string	"%p: 0x%x\n"
	.align 4
.LC6:
	.string	"i = %d; tmp= %d; ct = %d; &tmp = %p\n"
.LC7:
	.string	"AFTER iteration %d\n"
.LC8:
	.string	"buf = %s\n"
.LC9:
	.string	"victim: %p\n"
	.text
.globl victim
	.type	victim, @function
victim:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$52, %esp
	movl	$0, 20(%ebp)
	jmp	.L2
.L3:
	movl	20(%ebp), %eax
	movb	$0, -20(%ebp,%eax)
	addl	$1, 20(%ebp)
.L2:
	cmpl	$11, 20(%ebp)
	jbe	.L3
	leal	-20(%ebp), %eax
	movl	%eax, 16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	$.LC0, %eax
	movl	$main, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$.LC1, %eax
	movl	$JMP_ADDR, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$.LC2, %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$.LC3, %eax
	leal	-20(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$.LC4, %eax
	movl	%eax, (%esp)
	call	printf
	leal	-20(%ebp), %eax
	subl	$8, %eax
	movl	%eax, 20(%ebp)
	jmp	.L4
.L5:
	movl	20(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %ecx
	movl	20(%ebp), %edx
	movl	$.LC5, %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	addl	$1, 20(%ebp)
.L4:
	leal	8(%ebp), %eax
	addl	$8, %eax
	cmpl	20(%ebp), %eax
	ja	.L5
	movl	$1, 20(%ebp)
	jmp	.L6
.L10:
	movl	8(%ebp), %ecx
	movl	-24(%ebp), %edx
	movl	$.LC6, %eax
	leal	-24(%ebp), %ebx
	movl	%ebx, 16(%esp)
	movl	%ecx, 12(%esp)
	movl	%edx, 8(%esp)
	movl	20(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	20(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	strcpy
	movl	$.LC7, %eax
	movl	20(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	leal	-20(%ebp), %eax
	subl	$8, %eax
	movl	%eax, 24(%ebp)
	jmp	.L7
.L8:
	movl	24(%ebp), %eax
	movzbl	(%eax), %eax
	movzbl	%al, %ecx
	movl	24(%ebp), %edx
	movl	$.LC5, %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	addl	$1, 24(%ebp)
.L7:
	leal	8(%ebp), %eax
	addl	$8, %eax
	cmpl	24(%ebp), %eax
	ja	.L8
	movl	20(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	strlen
	addl	%eax, 16(%ebp)
	movl	20(%ebp), %eax
	leal	1(%eax), %edx
	movl	-24(%ebp), %eax
	cmpl	%eax, %edx
	je	.L9
	movl	16(%ebp), %eax
	movb	$32, (%eax)
	addl	$1, 16(%ebp)
.L9:
	addl	$1, 20(%ebp)
.L6:
	movl	-24(%ebp), %eax
	cmpl	20(%ebp), %eax
	ja	.L10
	movl	$.LC8, %eax
	leal	-20(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$.LC9, %eax
	movl	$victim, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	addl	$52, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	victim, .-victim
	.section	.rodata
.LC10:
	.string	"In shell\n"
.LC11:
	.string	"i = %d; inputs = %p\n"
.LC12:
	.string	"Inside here\n"
.LC13:
	.string	"/bin/sh"
.LC14:
	.string	"After cond\n"
	.text
.globl shell
	.type	shell, @function
shell:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$.LC10, %eax
	movl	%eax, (%esp)
	call	printf
	movl	$.LC11, %eax
	movl	12(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	cmpl	$0, 8(%ebp)
	jne	.L13
	movl	$.LC12, %eax
	movl	%eax, (%esp)
	call	printf
	movl	$.LC13, (%esp)
	call	system
.L13:
	movl	$.LC14, %eax
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	shell, .-shell
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$48, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
JMP_ADDR:
	call	shell
	movl	$0, 16(%esp)
	movl	$0, 12(%esp)
	movl	44(%esp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	victim
	movl	$0, (%esp)
	call	exit
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
