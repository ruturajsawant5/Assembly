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

	msg_start: 
	.string	"[START]<->" 

	msg_data: 
	.string	"[%d]<->" 

	msg_end: 
	.string	"[END]" 

	asm_proof:
	.string	"LINKED LIST DONE THROUGH ASSEMBLY!!!!" 

.section .text 

.globl	create_list 
.type 	create_list, @function 
.equ	head_node, loc1 
.equ	LOCAL_STORAGE, 4 
create_list: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 
	
	movl	$NULL, head_node(%ebp) 

	pushl	$-1 
	call	get_node 
	addl	$4, %esp 

	movl	%eax, head_node(%ebp) 
	movl	%eax, prev(%eax) 
	movl	%eax, next(%eax) 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	insert_start 
.type	insert_start, @function 
.equ	head_node, p1 
.equ	new_data, p2 
insert_start: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	new_data(%ebp), %eax 
	pushl	%eax 
	call	get_node 
	addl	$4, %esp 
#   at this point eax contains address of new node 

	movl	head_node(%ebp), %ebx # ebx <- head_node 
	movl	next(%ebx), %edx # edx <- head_node->next 

	pushl	%edx 	# push head_node->next
	pushl	%eax 	# push new_node 
	pushl	%ebx 	# push head_node 
	call	generic_insert 
	addl	$12, %esp 
	
	movl	$SUCCESS, %eax 
	
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	insert_end 
.type	insert_end, @function 
.equ	head_node, p1 
.equ	new_data, p2 
insert_end: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	new_data(%ebp), %eax 
	pushl	%eax 
	call	get_node 
	addl	$4, %esp 
# eax contains address of newly allocated node 
# at this point 

	movl	head_node(%ebp), %ebx # ebx <- head_node  
	movl	prev(%ebx), edx # edx <- head_node->prev 

	pushl	%ebx # push the head node 
	pushl	%eax # push the new node 
	pushl	%edx # push the last node 
	call	generic_insert 
	addl	$12, %esp 

	movl	$SUCCESS, %eax 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	insert_after 
.type	insert_after, @function 
.equ	head_node, p1 
.equ	e_data, p2 
.equ	new_data, p3 
.equ	e_node, loc1
.equ	LOCAL_STORAGE, 4 
insert_after: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 

	movl	head_node(%ebp), %eax 
	movl	e_data(%ebp), %edx 
	pushl	%edx 
	pushl 	%eax 
	call	search_node 
	addl	$8, %esp 
	
	cmpl	$NULL, %eax 
	je 		ins_aft_data_not_found 
	movl	%eax, e_node(%ebp) 

	movl	new_data(%ebp), %eax 
	pushl	%eax 
	call	get_node 
	addl	$4, %esp 

	movl	e_node(%ebp), %ebx 
	movl	next(%ebx), %edx 
	
	pushl	%edx 
	pushl	%eax 
	pushl	%ebx 
	call	generic_insert 
	addl	$12, %esp 
	movl	$SUCCESS, %eax 
	jmp		ins_aft_out 

ins_aft_data_not_found: 
	movl	$LIST_DATA_NOT_FOUND, %eax 
ins_aft_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl 	insert_before 
.type 	insert_before, @function 
.equ	head_node, p1 
.equ	e_data, p2 
.equ	new_data, p3 
.equ	e_node, loc1 
.equ	LOCAL_STORAGE, 4 
insert_before: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl 	$LOCAL_STORAGE, %esp 
	
	movl	head_node(%ebp), %eax 
	movl	e_data(%ebp), %edx 

	pushl	%edx 
	pushl	%eax 
	call	search_node 
	addl	$8, %esp 
	cmpl	$NULL, %eax 
	je 		ins_before_data_not_found 
	movl	%eax, e_node(%ebp) 

	movl	new_data(%ebp), %eax 
	pushl	%eax 
	call	get_node 
	addl	$4, %esp 

	movl	head_node(%ebp), %ebx 
	movl	prev(%ebx), %edx 

	pushl	%ebx 
	pushl	%eax 
	pushl	%edx 
	call	generic_insert 
	addl	$12, %esp 

	movl	$SUCCESS, %eax 
	jmp		ins_before_out
	
ins_before_data_not_found: 
	movl	$LIST_DATA_NOT_FOUND, %eax 
ins_before_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	get_start
.type	get_start, @function 
.equ	head_node, p1 
.equ	p_start_data, p2 
get_start: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je 		get_start_list_empty
	
	movl	head_node(%ebp), %eax # eax <- head_node 
	movl	next(%eax), %eax # eax <- head_node->next 
	movl	data(%eax), %edx # edx <- head_node->next->data 
	movl	p_start_data(%ebp), %eax 
	movl	%edx, (%eax) 
	movl	$SUCCESS, %eax 
	jmp		get_start_out 

get_start_list_empty: 
	movl	$LIST_EMPTY, %eax 
get_start_out
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	get_end 
.type	get_end, @function 
.equ	head_node, p1 
.equ	p_end_data, p2 
get_end: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je 		get_end_list_empty 
	
	movl	head_node(%ebp), %eax 
	movl	prev(%eax), %eax 
	movl	data(%eax), %edx 
	movl	p_end_data(%ebp), %eax 
	movl	%edx, (%eax) 
	movl	$SUCCESS, %eax 
	jmp		get_end_out 

get_end_list_empty: 
	movl	$LIST_EMPTY, %eax 
get_end_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	pop_start 
.type	pop_start, @function 
.equ	head_node, p1 
.equ	p_start_data, p2 
pop_start: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je 		pop_start_list_empty 

	movl	head_node(%ebp), %eax 
	movl	next(%eax), %eax 
	movl	data(%eax), %edx 
	movl	p_start_data(%ebp), %ebx 
	movl	%edx, (%ebx) 

	pushl	%eax 
	call	generic_delete 
	addl	$4, %esp 

	movl	$SUCCESS, %eax 
	jmp		pop_start_out 
	
pop_start_list_empty: 
	movl	$LIST_EMPTY, %eax 
pop_start_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	pop_end 
.type	pop_end, @function 
.equ	head_node, p1 
.equ	p_end_data, p2 
pop_end: 
	pushl	%ebp 
	movl	%esp, %ebp 

	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je 		pop_end_list_empty 
	
	movl	head_node(%ebp), %eax 
	movl	prev(%eax), %eax 
	movl	data(%eax), %edx 

	movl	p_end_data(%ebp), %ebx 
	movl	%edx, (%ebx) 

	pushl	%eax 
	call	generic_delete 
	addl	$4, %esp 

	movl	$SUCCESS, %eax 
	jmp		pop_end_out 

pop_end_list_empty: 
	movl	$LIST_EMPTY, %eax 
pop_end_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	remove_start
.type	remove_start, @function 
.equ	head_node, p1 
remove_start: 
	pushl	%ebp 
	movl	%esp, %ebp 

	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je		remove_start_list_empty 

	movl	head_node(%ebp), %eax 
	movl	next(%eax), %eax 
	pushl	%eax 
	call	generic_delete 
	addl	$4, %esp 
	movl	$SUCCESS, %eax 
	jmp		remove_start_out 

remove_start_list_empty: 
	movl	$LIST_EMPTY, %eax 
remove_start_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	remove_end 
.type	remove_end, @function 
.equ	head_node, p1 
remove_end: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	is_empty 
	addl	$4, %esp 
	cmpl	$TRUE, %eax 
	je		remove_end_list_empty 
	
	movl	head_node(%ebp), %eax 
	movl	prev(%eax), %eax 
	pushl	%eax 
	call	generic_delete 
	addl	$4, %esp 
	movl	$SUCCESS, %eax 
	jmp		remove_end_out 

remove_end_list_empty: 
	movl	$LIST_EMPTY, %eax 
remove_end_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	remove_data 
.type	remove_data, @function 
.equ	head_node, p1 
.equ	r_data, p2 
.equ	remove_node, loc1 
.equ	LOCAL_STORAGE, 4 
remove_data: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 

	movl	head_node(%ebp), %eax 
	movl	r_data(%ebp), %edx 
	pushl	%edx 
	pushl	%eax 
	call	search_node 
	addl	$8, %esp 

	cmpl	$NULL, %eax 
	je 		remove_data_list_data_not_found 
	
	movl	%eax, remove_node(%ebp) 

	pushl	%eax 
	call	generic_delete 
	addl	$4, %esp 

	movl	$SUCCESS, %eax 
	jmp		remove_data_out 

remove_data_list_data_not_found: 
	movl	$LIST_DATA_NOT_FOUND, %eax 
remove_data_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	get_length 
.type	get_length, @function 
.equ	head_node, p1 
.equ	L, loc1 
.equ	run, loc2 
.equ	LOCAL_STORAGE, 8 
get_length: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 

	movl	$0, L(%ebp) 
	movl	head_node(%ebp), %eax 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
	jmp		gl_cond_1 
gl_for_1: 
	addl	$1, L(%ebp) 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
gl_cond_1: 
	movl	run(%ebp), %eax 
	cmpl	head_node(%ebp), %eax 
	jne 	gl_for_1

	movl	L(%ebp), %eax 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	is_empty 
.type	is_empty, @function 
.equ	head_node, p1 
is_empty: 
	pushl	%ebp 
	movl	%esp, %ebp 

	movl	head_node(%ebp), %ebx 
	movl	prev(%ebx), %eax 
	movl	next(%ebx), %edx 

	cmpl	%eax, %ebx 
	jne 	ie_false 

	cmpl	%edx, %eax 
	jne 	ie_false

	movl	$TRUE, %eax 
	jmp		ie_out 

ie_false: 
	movl	$FALSE, %eax 
ie_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	show 
.type	show, @function 
.equ	head_node, p1 
.equ	msg, p2 
.equ	run, loc1 
.equ	LOCAL_STORAGE, 4 
show: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 
	
	movl	msg(%ebp), %eax 
	cmpl	$NULL, %eax 
	je 		show_continue 

	pushl	%eax 
	call	puts 
	addl	$4, %esp 

show_continue: 	
	pushl	$msg_start 
	call	printf
	addl	$4, %esp 

	movl	head_node(%ebp), %eax 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
	jmp		show_cond_1 
show_for_1: 
	movl	data(%eax), %edx 
	pushl	%edx 
	pushl	$msg_data 
	call	printf
	addl	$8, %esp 
	movl	run(%ebp), %eax 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
show_cond_1: 
	movl	run(%ebp), %eax 
	cmpl	head_node(%ebp), %eax 
	jne		show_for_1

	pushl	$msg_end 
	call	puts 
	addl	$4, %esp 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	destroy_list 
.type 	destroy_list, @function 
.equ	pp_node, p1 
.equ	head_node, loc1 
.equ	run, loc2 
.equ	run_next, loc3 
.equ	LOCAL_STORAGE, 12 
destroy_list: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 
	
# type(pp_node) == struct node** 
	movl	pp_node(%ebp), %eax # eax <- pp_node 
	movl	(%eax), %eax # eax <- *pp_node 
	movl	%eax, head_node(%ebp) 

	movl	head_node(%ebp), %eax 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
	jmp		destroy_cond_1 
destroy_for_1: 
	movl	next(%eax), %edx 
	movl	%edx, run_next(%ebp) 

	pushl	%eax 
	call	free 
	addl	$4, %esp 

	movl	run_next(%ebp), %eax 
	movl	%eax, run(%ebp) 
destroy_cond_1: 
	movl	run(%ebp), %eax
	cmpl	head_node(%ebp), %eax 
	jne		destroy_for_1

	movl	head_node(%ebp), %eax 
	pushl	%eax 
	call	free 
	addl	$4, %esp 
	movl	$NULL, head_node(%ebp) 

	movl	$SUCCESS, %eax 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	search_node 
.type 	search_node, @function 
.equ	head_node, p1 
.equ	search_data, p2 
.equ	run, loc1 
.equ	LOCAL_STORAGE, 4 
search_node: 
	pushl	%ebp 
	movl	%esp, %ebp 
	subl	$LOCAL_STORAGE, %esp 

	movl	$NULL, run(%ebp) 
	movl 	head_node(%ebp), %eax 
	movl	next(%eax), %edx 
	movl	%edx, run(%ebp) 
	jmp		sn_cond_1 
sn_for_1: 
	movl	data(%eax), %edx 
	cmpl	search_data(%ebp), %edx 
	je 		sn_out 
	movl	next(%eax), %eax 
	movl	%eax, run(%ebp) 
sn_cond_1: 
	movl	run(%ebp), %eax 
	cmpl 	head_node(%ebp), %eax 
	jne 	sn_for_1 
	
	movl	$NULL, %eax 
sn_out: 
	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	generic_insert 
.type 	generic_insert, @function 
.equ	beg, p1 
.equ	mid, p2 
.equ	end, p3 
generic_insert: 
	pushl	%ebp 
	movl	%esp, %ebp 
	
	movl	beg(%ebp), %eax 	# eax == beg 
	movl	mid(%ebp), %ebx 	# ebx == mid 
	movl	end(%ebp), %edx 	# edx == end 

	movl	%eax, prev(%ebx) 	# mid->prev = beg; 
	movl	%edx, next(%ebx) 	# mid->next = end;  
	movl	%ebx, next(%eax) 	# beg->next = mid; 
	movl	%ebx, prev(%edx) 	# end->prev = mid; 

	movl	%ebp, %esp 
	popl	%ebp 
	ret 

.globl	generic_delete 
.type	generic_delete, @function 
.equ	delete_node, p1 
generic_delete: 
	pushl	%ebp 
	movl	%esp, %ebp 

	movl	delete_node(%ebp), %ebx  # ebx = delete_node
	movl	prev(%ebx), %eax # eax = delete_node->prev
	movl	next(%ebx), %edx # edx = delete_node->next 

# delete_node->next->prev = delete_node->prev
	movl	%eax, prev(%edx)
# delete_node->prev->next = delete_node->next 	
	movl	%edx, next(%eax) 

# free(delete_node) 
	pushl	%ebx 
	call	free 
	addl	$4, %esp 
	
	movl	%ebp, %esp 
	popl 	%ebp 
	ret 

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

