#include <stdio.h> 
#include <stdlib.h> 

struct A {
	char  : 0; 
	int a : 3; 
	int b : 2; 
	int c : 2; 
}__attribute__((packed)); 

int main(void){
	printf("sizeof(struct A)=%u\n", sizeof(struct A)); 
	exit(EXIT_SUCCESS); 
}
