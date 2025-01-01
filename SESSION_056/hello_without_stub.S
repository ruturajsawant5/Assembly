.section .data 
	.globl	msg 
	.type	msg, @object 
	.size	msg, 26 
	.align	4 
	msg:
	.string	"HELLO,WORLD WITHOUT STUB!\n"

.section .text 
.globl	_start
_start: 
	movl	$4, %eax 	# eax <- system call number of write 
	movl	$1, %ebx 
	movl	$msg, %ecx 
	movl	$26, %edx 
	int		$0x80
	
	movl	$1, %eax 	# eax <- system call number of _exit 
	movl	$0, %ebx 
	int		$0x80 

