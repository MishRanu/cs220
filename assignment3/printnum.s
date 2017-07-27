# Program to print a number on the standard output.

.section .data
number:
  .long 1234534					# The number to print
a:
  .ascii "0"					# The ascii character memory assignment

.section .text
.globl _start

_start:
  movl number, %eax				# %eax contains the number
  movl $0, %edx					# initializing %edx for the division
  movl $10, %ebx				# Putting 10 as divisor in %ebx
  movl $0, %edi					# Initializing %edi to store the length of the number (number of digits)
  divl %ebx
  pushl %edx					# Push the least significant digit into the stack (remainder)
  incl %edi					# Increment the length of the number

  stack_loop:
    cmpl $0, %eax				# If the quotient after division is 0, start printing 
    je print
    movl $0, %edx
    movl $10, %ebx				# Extract the next digit through the same process
    divl %ebx
    pushl %edx
    incl %edi
    jmp stack_loop				

  print:
    popl %ecx					# Popping the last value stored (most significant digit) into %ecx
    addl %ecx, a				# Modifying the ascii value at $a to represent the current digit
    movl $4, %eax				# SYSCALL write
    movl $1, %ebx				# To specify the write location STDOUT
    movl $a, %ecx				# Location of the write buffer
    movl $1, %edx				# Length of the buffer = 1 character
    int $0x80					# Execute syscall
    movl $'0', a				# Reassign the ascii value '0' to a for the next iteration
    decl %edi
    cmpl $0, %edi				# Execute the print loop for the entire length of the number	
    je exit					# If done, exit
    jmp print

  exit:
    movl $'\n', a 
    movl $4, %eax				# Print a newline for nice output
    movl $1, %ebx
    movl $a, %ecx
    movl $1, %edx
    int $0x80

    movl $1, %eax
    movl $0, %ebx				# SYSCALL exit
    int $0x80
