	.file	"compute_4.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$20, %esp
	movl	$100, -20(%ebp)
	movl	$200, -16(%ebp)
	movl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	call	compute_1
	movl	%eax, -12(%ebp)
	movl	$30, %ecx
	movl	$20, %edx
	movl	$10, %eax
	call	compute_2
	movl	%eax, -12(%ebp)
	movl	$0, %eax
	addl	$20, %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.globl	compute_1
	.type	compute_1, @function
compute_1:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	%eax, -20(%ebp)
	movl	%edx, -24(%ebp)
	movl	-20(%ebp), %edx
	movl	-24(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%ebp)
	movl	-20(%ebp), %eax
	subl	-24(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	compute_1, .-compute_1
	.globl	compute_2
	.type	compute_2, @function
compute_2:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$12, %esp
	movl	%eax, -4(%ebp)
	movl	%edx, -8(%ebp)
	movl	%ecx, -12(%ebp)
	movl	-4(%ebp), %eax
	subl	-8(%ebp), %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	compute_2, .-compute_2
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits


# Intel Microrprocessor : 32 
# eax, ebx, ecx, edx, esi, edi, ebp, esp 


