#include <stdio.h> 
#include <stdlib.h> 

int __attribute__((regparm(3)))	compute_1(int, int); 

int __attribute__((regparm(3))) compute_2(int, int, int); 

int main(void) 
{
	int p = 100; 
	int q = 200; 
	int ans; 

	ans = compute_1(p, q); 
	ans = compute_2(10, 20, 30); 

	return (0); 
}

int __attribute__((regparm(3))) compute_1(int n1, int n2)
{
	int x, y; 

	x = n1 + n2; 
	y = n1 - n2; 

	return (x+y); 
}

int __attribute__((regparm(3))) compute_2(int x, int y, int z)
{
	return x - y + z; 
}
