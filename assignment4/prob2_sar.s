# Program for the second problem in Assignment 4

.section .data
error:
   .ascii "Invalid input. Please enter positive integers:\n"
error_end:

input_m:
   .rept 10
      .ascii "0"			# Storage for input string for m
   .endr

input_n:
   .rept 10
      .ascii "0"			# Storage for input string for n
   .endr

a:
   .ascii "0"				# Character for printing the result as an integer

.section .text
.globl _start

_start:
################ Taking m as input ###############
   movl $3, %eax			# SYS_READ call
   movl $0, %ebx			# Read from STDIN
   movl $input_m, %ecx			# Location for the read
   movl $10, %edx			# To read the input string
   int $0x80

   movl $0, %ecx			# Initializing %ecx to store the input number m converted to an integer
   movl $input_m, %edi			# Storing the address of the input string in edi for iteration
   cmpb $'-', (%edi)			# Check if the input number was negative
   je print_error

   loop_m:
      cmpb $'\n', (%edi)		# If the number has ended or not
      pushl %ecx 			# Store the value of m in the stack
      je break_m			# Break loop if newline is encountered
      imull $10, %ecx			# Multiply by 10 to store the input as a decimal integer
      subb $'0', (%edi)
      addb (%edi), %cl			# Adding the input digit to the current number
      incl %edi				# Going to the next character
      jmp loop_m

############### Taking n as input ################
   break_m:
      movl $3, %eax			# SYS_READ call
      movl $0, %ebx			# Read from STDIN
      movl $input_n, %ecx		# Location for the read
      movl $10, %edx			# To read the input string
      int $0x80

      movl $0, %edx			# Initializing %edx to store the input number n converted to an integer
      movl $input_n, %edi		# Storing the address of the input string in edi for iteration
      cmpb $'-', (%edi)			# Check if the input number was negative
      je print_error

      loop_n:
         cmpb $'\n', (%edi)		# If the number has ended or not
         je break_n			# Break loop if newline is encountered
         imull $10, %edx		# Multiply by 10 to store the input as a decimal integer
         subb $'0', (%edi)
         addb (%edi), %dl		# Adding the input digit to the current number
         incl %edi			# Going to the next character
         jmp loop_n
############# Computing the value of A(m, n) ##############
   break_n:				# The input values have been read. Proceeding to the function now
      popl %ecx				# Pop the value of m back into %ecx
      pushl %edx			# The second parameter = n is pushed
      pushl %ecx			# The first parameter = m is pushed
      call A				# Calling the function A(m, n) with %eax storing the return value
      call print_number			# Call function to print the value in %eax as an ascii string
      #### EXIT ####
      movl $1, %eax			# Syscall exit
      movl $0, %ebx			# Return value is 0
      int $0x80

############## Definition of A ###############
   A:
      pushl %ebp			# Saving the base pointer
      movl %esp, %ebp			# Using ebp to access the stack
      cmpl $0, 8(%ebp)			# If m = 0, basecase is reached
      je base				# Go to the base case branch

      cmpl $0, 12(%ebp)			# If n = 0
      je n_zero				# Go to the branch where n = 0

      movl 12(%ebp), %ebx		# The second parameter is stored in ebx
      decl %ebx				# Basically we have n-1 in ebx now
      pushl %ebx			# Pushing n-1 to the stack for the recursive call
      pushl 8(%ebp)			# First parameter is the same = m
      call A				# Calling A(m, n-1)
      addl $8, %esp			# Removing the parameters of the previous call from the stack

      pushl %eax			# Push the return value of A(m, n-1) to the stack as the second parameter of the recursive call
      movl 8(%ebp), %ebx		# The first parameter = m is put into ebx
      decl %ebx				# Decrement ebx to get m-1
      pushl %ebx			# Pushing m-1 to the stack as the first parameter of the recursive call
      call A				# Calling A(m-1, A(m, n-1))
      addl $8, %esp			# Removing the parameters of the previous call from the stack

      movl %ebp, %esp			# Restoring the value of esp
      popl %ebp				# Restoring the value of ebp
      ret

      n_zero:
         pushl $1			# When n = 0, second parameter of the recursive call is 1
	 movl 8(%ebp), %ebx		# ebx now stores m
	 decl %ebx			# ebx now stores m-1
	 pushl %ebx			# Push m-1 to the stack as the first parameter of the recursive call 
	 call A				# Call A(m-1, 1)
	 addl $8, %esp			# Removing the parameters from the stack

	 movl %ebp, %esp		# Restoring the value of esp
	 popl %ebp			# Restoring the value of ebp
	 ret

      base:				# Base case: m = 0
         movl 12(%ebp), %eax		# eax stores the value of n now
	 incl %eax			# eax = eax + 1; eax now stores n+1

	 movl %ebp, %esp
	 popl %ebp
	 ret				# Return with return value in eax			

############### Definition of the function to print the result ################
   print_number:				# Function to print the number
      movl $0, %edx				# initializing %edx for the division
      movl $10, %ebx				# Putting 10 as divisor in %ebx
      movl $0, %edi				# Initializing %edi to store the length of the number (number of digits)
      divl %ebx
      pushl %edx				# Push the least significant digit into the stack (remainder)
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
         popl %ecx				# Popping the last value stored (most significant digit) into %ecx
         addl %ecx, a				# Modifying the ascii value at $a to represent the current digit
         movl $4, %eax				# SYSCALL write
         movl $1, %ebx				# To specify the write location STDOUT
         movl $a, %ecx				# Location of the write buffer
         movl $1, %edx				# Length of the buffer = 1 character
         int $0x80				# Execute syscall
         movl $'0', a				# Reassign the ascii value '0' to a for the next iteration
         decl %edi
         cmpl $0, %edi				# Execute the print loop for the entire length of the number	
         je return				# If done, return
         jmp print
         return:
	    movl $'\n', a			# For printing a newline
	    movl $4, %eax
	    movl $1, %ebx
	    movl $a, %ecx
	    movl $1, %edx
	    int $0x80
            ret

   print_error:				# If negative number(s) are given as input
      movl $4, %eax			# Syswrite call
      movl $1, %ebx			# Print on STDOUT
      movl $error, %ecx			# Location of the error message
      movl $(error_end - error), %edx	# Size of the error message
      int $0x80
      jmp _start			# Go back to the start to take new inputs
