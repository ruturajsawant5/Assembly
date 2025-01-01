#include <stdio.h>
#include <stdlib.h> 

#define SUCCESS 				1 
#define LIST_DATA_NOT_FOUND 	2
#define LIST_EMPTY 				3 


struct node{
	int data; 
	struct node* prev; 
	struct node* next; 
}; 


struct node* get_node(int new_data); 
void* xcalloc(int nr_elements, int size_per_element); 
void generic_insert(struct node* beg, 
					struct node* mid, 
					struct node* next);
void generic_delete(struct node* delete_node); 
struct node* search_node(struct node* head_node, 
						 int search_data); 

struct node* create_list(void); 
int insert_start(struct node* head_node, int new_data); 
int insert_end(struct node* head_node, int new_data); 

struct node* create_list(void){
	struct node* head_node = NULL; 

	head_node = get_node(-1); 
	head_node->prev = head_node; 
	head_node->next = head_node; 

	return (head_node); 
}

int insert_start(struct node* head_node, int new_data){
	generic_insert(	
					head_node, 
					get_node(new_data), 
					head_node->next
				); 
	return (SUCCESS); 
}

int insert_end(struct node* head_node, int new_data){
	generic_insert(
					head_node->prev, 
					get_node(new_data), 
					head_node
				); 
	return (SUCCESS); 
}

int insert_after(	struct node* head_node, 
					int e_data, 
				 	int new_data
				){
	struct node* e_node = NULL; 

	e_node = search_node(head_node, e_data); 
	if(e_node == NULL) 
		return (LIST_DATA_NOT_FOUND); 
	generic_insert(
					e_node, 
					get_node(new_data), 
					e_node->next); 
	return (SUCCESS); 
}

int insert_before(
					struct node* head_node,
					int e_data, 
					int new_data
				){
	struct node* e_node = NULL; 
	e_node = search_node(head_node, e_data); 
	if(e_data == NULL) 
		return (LIST_DATA_NOT_FOUND); 
	generic_insert(
					e_node->prev, 
					get_node(new_data), 
					e_node
				); 
	return (SUCCESS); 
}

int get_start(struct node* head_node, int* p_start_data){
	if(is_empty(head_node) == TRUE) 
		return (LIST_EMPTY); 
	*p_start_data = head_node->next->data; 
	return (SUCCESS); 
}

int get_end(struct node* head_node, int* p_end_data){
	if(is_empty(head_node) == TRUE) 
		return (LIST_EMPTY); 
	*p_end_data = head_node->prev->data; 
	return (SUCCESS); 
}

int pop_start(struct node* head_node, int* p_start_data){
	if(is_empty(head_node) == TRUE)
		return (LIST_EMPTY); 
	*p_start_data = head_node->next->data; 
	generic_delete(head_node->next); 
	return (SUCCESS); 
}

int pop_end(struct node* head_node, int* p_end_data){
	if(is_empty(head_node) == TRUE)
		return (LIST_EMPTY); 
	*p_end_data = head_node->prev->data; 
	generic_delete(head_node->prev); 
	return (SUCCESS); 
}

int remove_start(struct node* head_node){
	if(is_empty(head_node) == TRUE) 
		return (LIST_EMPTY); 
	generic_delete(head_node->next); 
	return (SUCCESS); 
}

int remove_end(struct node* head_node){
	if(is_empty(head_node) == TRUE) 
		return (LIST_EMPTY); 
	generic_delete(head_node->prev); 
	return (SUCCESS); 
}

int remove_data(struct node* head_node, int r_data){
	struct node* remove_node = NULL; 

	remove_node = search_node(head_node, r_data); 
	if(remove_node == NULL) 
		return (LIST_DATA_NOT_FOUND); 

	generic_delete(remove_node); 
	return (SUCCESS); 
}

int get_length(struct node* head_node){
	int L; 
	struct node* run = NULL; 

	L = 0; 
	for(run = head_node->next; run != head_node; run = run->next)
		++L; 

	return (L); 
}

int is_empty(struct node* head_node){
	return (head_node->next == head_node && 
			head_node->prev == head_node); 
}

void show(struct node* head_node, const char* msg){
	struct node* run = NULL; 

	if(msg)
		puts(msg); 

	printf("[START]<->"); 
	for(run = head_node->next; run != head_node; run = run->next)
		printf("[%d]<->", run->data); 
	puts("[END]"); 
}

int destroy_list(struct node** pp_node){
	struct node* head_node = NULL; 
	struct node* run = NULL; 
	struct node* run_next = NULL; 

	head_node = *pp_node; 
	for(run = head_node->next; run != head_node; run = run_next){
		run_next = run->next; 
		free(run); 
	}
	
	free(head_node); 
	head_node = NULL; 

	return (SUCCESS); 
}

struct node* search_node(struct node* head_node, 
						 int search_data){
	struct node* run = NULL; 

	for(run = head_node->next; run != head_node; run = run->next)
		if(run->data == search_data) 
			return (run); 

	return (NULL); 
}

void generic_insert(struct node* beg, 
					struct node* mid, 
					struct node* end){
	mid->next = end;  
	mid->prev = beg;
	beg->next = mid; 
	end->prev = mid; 
}

void generic_delete(struct node* delete_node){
	delete_node->prev->next = delete_node->next; 
	delete_node->next->prev = delete_node->prev; 
	free(delete_node); 
} 

struct node* get_node(int new_data){
	struct node* p_node = NULL; 

	p_node = xcalloc(1, sizeof(struct node)); 
	p_node->data = new_data; 

	return (p_node); 
}

void* xcalloc(int nr_elements, int size_per_element){
	void* ptr = NULL; 

	ptr = calloc(nr_elements, size_per_element); 
	if(ptr == NULL){
		puts("Error in allocating memory"); 
		exit(EXIT_FAILURE);
	}

	return (ptr); 
}
