# This assembly source code allocates three integers each 
# 4 bytes long. The first number is set 100 and the second one 
# to 200 and third one to the addition of numbers in 
# first two. 

# This program will get assembled successfully in machine code 
# (with warning: entry point _start is missing). We can ignore 
# that warning at this stage 

# But trying to run this program will result into segmentation 
# fault because we are not properly exiting. 

.section .data 
	num1: 
	.int 	0 

	num2: 
	.int 	0 

	summation: 
	.int	0 

.section .text 
	movl	$100, num1 
	movl	$200, num2 
	movl	num1, %eax 
	movl	num2, %ebx 
	addl	%ebx, %eax 
	movl	%eax, summation 

