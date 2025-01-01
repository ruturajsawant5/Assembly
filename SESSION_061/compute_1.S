	.file	"compute_1.c"
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
	movl	$100, -20(%ebp) # -20(%ebp) == p 
	movl	$200, -16(%ebp) # -16(%ebp) == q 
	subl	$8, %esp

	pushl	-16(%ebp)	# Right to left order -> first -> q -> storage allocate 
	pushl	-20(%ebp)	# Right left order -> second -> p -> storage allocate 
	call	compute_1 	# On Intel hardware implementation of call instruction 
						# generates the address of next instruction and stores it on stack 
	
	addl	$16, %esp		# free the storage on stack allocated to formal parameters 
	movl	%eax, -12(%ebp)	# Copy the return vale to LHS of function call 
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	leave
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

	pushl	%ebp			# Save frame pointer of caller 
	movl	%esp, %ebp		# Set one's own frame pointer 
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%ebp)
	movl	8(%ebp), %eax
	subl	12(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax

	leave				# clear local storage + restore 
						# caller function frame pointer 
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret					# clear return address on stack 
						# goto caller 
	.cfi_endproc
.LFE3:
	.size	compute_1, .-compute_1
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
# leave == 
# movl %ebp, %esp 	# clear local storage 
# popl %ebp 		# caller function's frame pointer restore 
