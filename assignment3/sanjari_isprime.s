# Program to calculate maximum from a list of numbers, terminated by 0

.section .data

num:
  .long 29

digit:
	.ascii "0"

isprime:
	.ascii " it is a prime number.\n"
isprime_end:

notprime:
	.ascii " is not a prime number.\n"
notprime_end:


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
	je check_prime
	movl $'0', digit
	decl %edi
	popl %ecx
	addl %ecx, digit
	movl $4, %eax                   # 4 is the system call number
	movl $1, %ebx                   # 1 stands for stdout
	movl $digit, %ecx
	movl $1, %edx # Size of the BUFFER
	int $0X80
	jmp print
		

	
  check_prime:
	movl num, %eax
	cmpl $1, %eax
	je print_prime
	movl $0, %edx
	movl $2, %ebx
	divl %ebx
	
 loop:
	cmpl $0, %edx
	je print_notprime
	movl num, %eax
	movl $0,%edx
	incl %ebx
	cmpl %eax, %ebx
	je print_prime	
	divl %ebx

	jmp loop

print_prime:
          movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $isprime, %ecx
	  movl $(isprime_end-isprime), %edx # Size of the buffer
	  int $0x80
	  jmp exit


print_notprime:
	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $notprime, %ecx
	  movl $(notprime_end-notprime), %edx # Size of the buffer
	  int $0x80
	  jmp exit

exit:
    movl $1, %eax
    movl $0, %ebx				# SYSCALL exit
    int $0x80
