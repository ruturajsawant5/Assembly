.section .rodata 
# char* p = "Hello,World!"; 
.globl p 
.type p, @object 
.size p, 13 
.align 4 
p: 
.string "Hello,World!" 

str0: 
.string	"Pune" 

str1: 
.string	"Nagpur" 

str2: 
.string	"Mumbai" 

.section .data 

# char c = 'A'; 
.globl c 
.type c, @object 
.size c, 1 
.align 4 
c: 
.ascii "A" 

# unsigned char uc = 125; 
.globl uc 
.type uc, @object 
.size uc, 1 
.align 4 
uc: 
.byte 125 

# short snum = -100; 
.globl snum 
.type snum, @object 
.size snum, 2 
.align 4 
snum: 
.value -100 

# unsigned short usnum = 0xffff; 
.globl usnum 
.type usnum, @object 
.size usnum, 2 
.align 4 
usnum: 
.value 0xffff

# int inum = 34535; 
.globl inum 
.type inum, @object 
.size inum, 4 
.align 4 
inum: 
.int 34535 

# unsigned int uinum = 0xa0b0c0d0; 
.globl uinum 
.type uinum, @object 
.size uinum, 4
.align 4 
uinum: 
.int 0xa0b0c0d0 


# long l_num = 36435436; 
.globl l_num 
.type l_num, @object 
.size l_num, 4 
.align 4 
l_num: 
.long 36435436 

# unsigned long ul_num = 0x46356 
.globl ul_num 
.type ul_num, @object 
.size ul_num, 4 
.align 4 
ul_num: 
.long 0x46456

# long long ll_num = 34636364736 
.globl ll_num 
.type ll_num, @object 
.size ll_num, 8 
.align 8 
ll_num: 
.long 	0x107CFBC0 
.long 	0x00000008

# unsigned long long ull_num = 0xa0b0c0d010203040
.globl ull_num 
.type ull_num, @object 
.size ull_num, 8 
.align 8 
ull_num: 
.long 	0x10203040
.long 	0xa0b0c0d0

.type i, @object 
.size i, 4 
.align 4 
i: 
.int 500 

# char msg[] = "Hello,World!"; 
.globl msg 
.type msg, @object 
.size msg, 13 
.align 4 
msg: 
.string	"Hello,World!" 

# int a[5] = {100, 200, 300, 400, 500}; 
.globl a 
.type a, @object 
.size a, 20 
.align 4 
a: 
.int 100 
.int 200 
.int 300 
.int 400 
.int 500 

# short b[] = {10, 20, 30}; 
.globl b
.type b, @object 
.size b, 6 
.align 4 
b: 
.value 10, 20, 30 

# struct Student st_mstc = {121, "Pune", 78}; 

.globl st_mstc 
.type st_mstc, @object 
.size st_mstc, 12 
.align 4 
st_mstc: 
.int 	121
.long 	str0
.value 	78 
.zero 	2 

# 
.globl st_arr 
.type st_arr, @object 
.size st_arr, 60 
.align 4 
st_arr: 
.int 207 
.long str0 
.value 80
.zero 2 	# index 0 end 

.int 223 
.long str1 
.value 82 
.zero 2 	# index 1 end 

.int 145 
.long str2 
.value 75 
.zero 2 	# index 2 end 

.int 137 
.long str0 
.value 90 
.zero 2 	# index 3 end 

.int 89 
.long str2 
.value 95 
.zero 2 	# index 4 end, st_arr end 





























