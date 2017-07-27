# Program to calculate the maximum money we can get from n Bytelandian coins

.section .data
input:
   .rept 10
      .ascii "0"				# Characters for taking the input
   .endr

a:
   .ascii "0"					# Character for printing the output

.section .text
.globl _start

_start:

############## Taking input n ###############

   movl $3, %eax			# SYS_READ call
   movl $0, %ebx			# Read from STDIN
   movl $input, %ecx			# Location for the read
   movl $10, %edx			# To read the input string
   int $0x80

   movl $0, %edx			# Initializing %edx to store the input converted to an integer
   movl $input, %edi			# Storing the address of the input string in edi for iteration

   loop:
      cmpb $'\n', (%edi)		# If the number has ended or not
      je break				# Break loop if newline is encountered
      imull $10, %edx			# Multiply by 10 to store the input as a decimal integer
      subb $'0', (%edi)
      addb (%edi), %dl			# Adding the input digit to the current number
      incl %edi				# Going to the next character
      jmp loop

   break:
      pushl %edx			# Pushing n to the stack as the function parameter
      call max_money			# The function max_money(n) is called
      call print_number			# Print the output value (return value of max_money(n)) stored in %eax
      ##### EXIT #####
      movl $1, %eax			# Syscall exit
      movl $0, %ebx			# Exit with status 0
      int $0x80

####### Defining function max_money(n) ##########

   max_money:				# Defining the recursive function
      pushl %ebp			# Saving the value of the base pointer
      movl %esp, %ebp			# Base pointer now stores the current stack pointer
      subl $4, %esp			# Allocate 4 bytes of local variable storage on the stack
      cmpl $0, 8(%ebp)			# If n == 0, base case
      je base

####### Calculating max_money(n/2) #########

      movl 8(%ebp), %eax		# Move n into eax 
      movl $2, %ebx			# Moving 2 into ebx for division
      movl $0, %edx			# Moving 0 to edx to store the remainder and to set the dividend correctly
      divl %ebx				# Divide %eax by %ebx and store the quotient (= n/2) in %eax

      pushl %eax			# Push n/2 as a parameter to the recursive call on the stack
      call max_money			# Call max_money(n/2)
      add $4, %esp			# Remove the parameter from the stack
      movl %eax, -4(%ebp)		# Store max_money(n/2) in local variable space

####### Calculating max_money(n/3) #########

      movl 8(%ebp), %eax		# Move n into eax
      movl $3, %ebx			# Move 3 into ebx for division
      movl $0, %edx
      divl %ebx				# Divide %eax by %ebx and store the quotient (= n/3) in %eax

      pushl %eax			# Push n/3 as a parameter to the recursive call on the stack
      call max_money			# Call max_money(n/3)
      add $4, %esp			# Remove the parameter from the stack
      addl %eax, -4(%ebp)		# Add max_money(n/3) to local variable

####### Calculating max_money(n/4) #########

      movl 8(%ebp), %eax		# Move n into eax
      movl $4, %ebx			# Move 4 into ebx for division
      movl $0, %edx
      divl %ebx				# Divide %eax by %ebx and store the quotient (= n/3) in %eax

      pushl %eax			# Push n/4 as a parameter to the recursive call on the stack
      call max_money			# Call max_money(n/4)
      add $4, %esp			# Remove the parameter from the stack
      addl %eax, -4(%ebp)		# Add max_money(n/4) to local variable. It now stores = max_money(n/2) + max_money(n/3) + max_money(n/4)

###### Calculating max(n, max_money(n/2)+max_money(n/3)+max_money(n/4)) ########
      
      movl -4(%ebp), %eax		# Move the contents of the local variable to eax
      cmpl 8(%ebp), %eax		# Check if n > max_money(n/2) + max_money(n/3) + max_money(n/4)
      jl return_max			# If true, return n
    					# Else return the contents of the local variable 
      movl %ebp, %esp			# Restore the value of the stack pointer
      popl %ebp				# Restore the value of the base pointer
      ret

      return_max:
         movl 8(%ebp), %eax		# Move n to the return value register eax
	 movl %ebp, %esp		# Restore the value of the stack pointer
	 popl %ebp			# Restore the value of the base pointer
	 ret

##### BASE CASE #######
      base:
         movl $0, %eax			# Return value is 0 if you have a coin of 0 value
	 movl %ebp, %esp 		# Restore the value of the stack pointer
	 popl %ebp			# Restore the value of the base pointer
	 ret

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
