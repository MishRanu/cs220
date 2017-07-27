# Program to output whether a given number is prime or not
# Re-uses code from printnum.s to print numbers

.section .data
number:
  .long 17

prime_op:
  .ascii " is a prime number.\n"
prime_op_end:

noprime_op:
  .ascii " is not a prime number.\n"
noprime_op_end:

a:
  .ascii "0"

.section .text
.globl _start

_start:
  cmpl $1, number				# Special case: number = 1
  je noprime
  cmpl $2, number				# Special case: number = 2
  je prime
  call check_prime
  cmpl $0, %eax					# %eax stores the return value of check_prime function
  je noprime					# Print 'not a prime' if check_prime returns 0
  jmp prime					# Print 'prime' otherwise

  check_prime:
    movl $2, %edi				# Initialize the iterator
    call modulo					# Check whether the number is divisible by 2 or not
    cmpl $0, %edx
    je return_noprime				# Not prime if the number is divisible by 2
    incl %edi					# Increment the iterator
    cmpl %edi, number				# If the number is 3
    je return_prime

    loop:
      call modulo				# Function modulo computes the remainder when the number is divided by %edi
      cmpl $0, %edx				# %edx stores the return value of the modulo function
      je return_noprime				# If number mod i == 0 then the number is not prime, return 0
      addl $2, %edi				# If number mod i is not 0, increment i by 2 and go through the loop again (only odd numbers)
      cmpl %edi, number				# If i = number, time to exit the loop and return 1, the number is prime
      je return_prime
      jmp loop

      return_noprime:
        movl $0, %eax				# Return value of check_prime is 0 since the number is not prime
        ret

      return_prime:
        movl $1, %eax				# Return value of check_prime is 1 since the number is prime
	ret

  modulo:
    movl $0, %edx				# Prepare to store remainder
    movl number, %eax				# Move the dividend to %eax
    divl %edi					# Perform the division, return value is automatically in %edx
    ret

  noprime:
    call print_number				# Printing the number first
    #### PRINT THE NOT PRIME STATEMENT HERE ####
    movl $4, %eax				# Syswrite call
    movl $1, %ebx
    movl $noprime_op, %ecx			# Location of the noprime statement
    movl $(noprime_op_end - noprime_op), %edx	# Size of the buffer
    int $0x80
    jmp exit					# Go to the exit block

  prime:
    call print_number				# Printing the number first
    #### PRINT THE PRIME STATEMENT HERE ####
    movl $4, %eax				
    movl $1, %ebx
    movl $prime_op, %ecx			# Location of the prime statement
    movl $(prime_op_end - prime_op), %edx	# Size of the buffer
    int $0x80
    jmp exit					# Go to the exit block

  print_number:					# Function to print the number
    movl number, %eax				# %eax contains the number
    movl $0, %edx				# initializing %edx for the division
    movl $10, %ebx				# Putting 10 as divisor in %ebx
    movl $0, %edi				# Initializing %edi to store the length of the number (number of digits)
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
      je return					# If done, return
      jmp print
      return:
        ret

  exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
