# Include general offsets file 
.include "offsets.S" 

# Offsets of members of struct node 
# with respect to base address of ANY 
# instance of struct node 

.equ	data, 0 
.equ	prev, 4 
.equ	next, 8 


# Offsets of members of struct node 
# with respect to base address of ANY 
# instance of struct node 

.equ	data, 0 
.equ	prev, 4 
.equ	next, 8 

# Symbolic constants 
.equ	SIZE_OF_NODE, 12
.equ	NULL, 0 
.equ	SUCCESS, 1 
.equ	LIST_DATA_NOT_FOUND, 2 
.equ	LIST_EMPTY, 3 

.section .rodata 
	
	msg_calloc_eror:
	.string	"fatal:calloc:out of memory" 

.section .text 

.globl	get_node 
.type	get_node, @function 
.equ	new_data, p1 
.equ	p_node, loc1 
.equ	LOCAL_STORAGE, 4 
get_node: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 

	pushl	$SIZE_OF_NODE 
	pushl	$1 
	call	xcalloc 
	addl	$8, %esp 

	movl	%eax, p_node(%ebp) 

	movl	new_data(%ebp), %edx 
	movl	%edx, data(%eax) 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 


.globl	xcalloc 
.type 	xcalloc, @function 

.equ	nr_elements, p1 
.equ	size_per_element, p2 
.equ	ptr, loc1 
.equ	LOCAL_STORAGE, 4 

xcalloc: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp
	
	movl	nr_elements(%ebp), %eax 
	movl	size_per_element(%ebp), %edx 

	pushl	%edx 
	pushl	%eax 
	call	calloc 
	cmpl	$NULL, %eax 
	je 		xc_calloc_error 
	movl	%eax, ptr(%ebp) 
	jmp		xc_out

xc_calloc_error: 
	pushl	$msg_calloc_error 
	call	puts 
	addl	$4, %esp 

	pushl	$EXIT_FAILURE 
	call	exit 
xc_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 


























