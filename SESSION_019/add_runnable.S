# This is a runnable version of add.S with output provision 

.section .rodata 
	msgP1:
	.string	"%d + %d = %d\n" 

	proof: 
	.string	"Roll 143 : Kartik Patil : Sniper" 

.section .data 
	.globl	num1 
	.type	num1, @object 
	.size	num1, 4 
	.align	4 
	num1: 
	.int	0 

	.globl	num2 
	.type	num2, @object 
	.size	num2, 4 
	.align	4 
	num2: 
	.int	0 

	.globl	summation 
	.type	summation, @object
	.size	summation, 4 
	.align	4 
	summation: 
	.int	0 

.section .text
.globl	main 
.type	main, @function 
main: 
	pushl	%ebp 
	movl	%esp, %ebp 

	movl	$100, num1 
	movl	$200, num2 

	movl	num1, %eax
	movl	num2, %ebx 
	addl	%ebx, %eax
	movl	%eax, summation 

	pushl	summation 
	pushl	num2 
	pushl	num1 
	pushl	$msgP1
	call	printf
	addl	$16, %esp 
	
	pushl	$proof 
	call	puts 
	addl	$4, %esp 

	pushl	$0 
	call	exit 

