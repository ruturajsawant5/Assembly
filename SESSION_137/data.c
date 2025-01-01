char c = 'A'; 
unsigned char uc = 125; 
short snum = -100; 
unsigned short usnum = 0xffff; 
int inum = 34535; 
unsigned int uinum = 0xa0b0c0d0; 
long l_num = 36435436; 
unsigned long ul_num = 0x46356; 
long long ll_num = 34636364736; // 0x00000008 107CFBC0  
unsigned long long ull_num = 0xa0b0c0d010203040; 

static int i = 500; 

////////////////////////////////////////////////////////

char* p = "Hello,World!"; // read only 
char msg[] = "Hello,World!"; // read write array 

int a[5] = {100, 200, 300, 400, 500}; 
short b[] = {10, 20, 30}; 

// exercise: 
// Take global initialized array of long and long long 
// and convert it into assembly 

// No conversion of following statement is present in assembly 
// because assembly does not have the notion of pure 
// declarative statement 
// it has only two things, definition and use 
struct Student{
	int st_roll; 
	char* st_city; 
	short st_marks; 
}; 

// This can be converted into assembly! 
struct Student st_mstc = {121, "Pune", 78}; 

struct Student st_arr[] = {
	{207, "Pune", 80}, 
	{223, "Nagpur", 82}, 
	{145, "Mumbai", 75}, 
	{137, "Pune", 90}, 
	{89, "Mumbai", 95}
}; 

/* 
st_arr[i].st_roll, 
st_arr[i].st_city, 
st_arr[i].st_marks, 
*/ 













