
.section .data

num:
  .long 123

digit:
	.ascii "0"

.section .text

.globl _start

_start:
	
	movl num, %eax
	movl $0, %edi

   start_loop:
	
	movl $10, %ebx
	movl $0, %edx
	divl %ebx 
	pushl %edx
	incl %edi
        cmpl $0, %eax
  	je print
        jmp start_loop


  print:
        cmpl $0, %edi
	je loop_exit
	movl $'0', digit
	decl %edi
	popl %ecx
	addl %ecx, digit
	
	 movl $4, %eax                   # 4 is the system call number
	 movl $1, %ebx                   # 1 stands for stdout
	 movl $digit, %ecx
	 movl $1, %edx # Size of the buffer
	 int $0x80
	 jmp print
		

 	
  loop_exit:
	  movl $'\n', digit
 	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $digit, %ecx
	  movl $1, %edx # Size of the buffer
	  int $0x80
          movl $1, %eax
          movl $0, %ebx				# SYSCALL exit
          int $0x80
