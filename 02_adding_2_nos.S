.section .rodata
    msg_1:
    .string "Enter First Number : "
    msg_2:
    .string "Enter Second Number : "
    msg_3:
    .string "%d"
    msg_4:
    .string "%d + %d = %d\n"

.section .bss
    .comm num1, 4, 4
    .comm num2, 4, 4
    .comm sum, 4, 4

.section .text
    .globl main
    .type main, @function
    main:
        
    #PROLOGUE
    pushl %ebp
    movl  %esp, %esp

    pushl $msg_1
    call  printf
    addl  $4, %esp

    pushl $num1
    pushl $msg_3
    call scanf
    addl $8, %esp

    pushl $msg_2
    call  printf
    addl  $4, %esp

    pushl $num2
    pushl $msg_3
    call  scanf
    addl  $8, %esp

    movl  num1, %eax
    movl  num2, %edx
    addl  %edx, %eax
    movl  %eax, sum

    pushl sum
    pushl num2
    pushl num1
    pushl $msg_4
    call  printf
    addl  $16, %esp

    push  $0
    call  exit
