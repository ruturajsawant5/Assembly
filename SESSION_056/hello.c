#include <unistd.h> 

int main(void) 
{
	write(1, "Hello,World through STUB!\n", 26); 
	_exit(0); 
}
