#include <stdio.h> 
#include <stdlib.h> 

#define STDCALL __attribute__((stdcall))

int STDCALL compute_1(int, int); 

int main(void) 
{
	int p = 100; 
	int q = 200; 
	int ans; 

	ans = compute_1(p, q); 

	return (0); 
}

int STDCALL compute_1(int n1, int n2)
{
	int x, y; 

	x = n1 + n2; 
	y = n1 - n2; 

	return (x+y); 
}