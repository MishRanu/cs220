# To solve the tower of hanoi problem

.section .data
a:
   .ascii "A"				# For tower A
b:
   .ascii "B"				# For tower B
c:
   .ascii "C"				# For tower C
out_string:
   .ascii "Move from "			# For beautiful output
out_string_end:

to:
   .ascii " to "			# For grammatically beautiful output 
to_end:

period:
   .ascii ".\n"				# Sentences need to be ended
period_end:

input:
   .rept 10
      .ascii "0" 			# For the input character
   .endr

.section .text
.globl _start

_start:
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

   break:				# The actual function starts now
      pushl $c				# The middle tower parameter
      pushl $b				# The destination tower parameter
      pushl $a				# The source tower parameter
      pushl %edx			# The number of disks parameter
      call hanoi			# Calling the function to make the moves as hanoi(num, src, dest, mid)
      ##### EXIT #####
      movl $1, %eax			# Syscall exit
      movl $0, %ebx			# Return value of the program
      int $0x80

   hanoi:
      pushl %ebp 			# Save the base pointer
      movl %esp, %ebp			# Use ebp for accessing parameters
      cmpl $1, 8(%ebp)			# Basecase: Number of disks is 1
      je base				# Jump to the base case branch
      
      pushl 16(%ebp)			# Middle parameter for the recursive call = destination parameter for the parent call
      pushl 20(%ebp)			# Destination parameter for the recursive call
      pushl 12(%ebp) 			# Source parameter for this recursive call
      movl 8(%ebp), %edx		# Number of disks is loaded to %edx
      decl %edx				# Decrementing number of disks for the recursive call
      pushl %edx			# Number of disks parameter for the recursive call
      call hanoi			# Basically this is the call hanoi(num-1, src, mid, dest)
      addl $16, %esp			# Removing the parameters from the stack

      pushl 20(%ebp)			# Middle parameter for the second recursive call
      pushl 16(%ebp) 			# Destination parameter for the second recursive call
      pushl 12(%ebp)			# Source parameter for the second recursive call
      pushl $1				# Number of disks = 1 for this call
      call hanoi 			# This is the call hanoi(1, src, dest, mid)
      addl $16, %esp 			# Removing the parameters

      pushl 12(%ebp)			# Middle parameter for the third recursive call
      pushl 16(%ebp)			# Destination parameter for the third recursive call
      pushl 20(%ebp) 			# Source parameter for the third recursive call
      movl 8(%ebp), %edx		# Number of disks is loaded to %edx
      decl %edx				# Decrementing number of disks for the third recursive call
      pushl %edx			# Number of disks parameter for the third recursive call
      call hanoi			# Basically this is the call hanoi(num-1, mid, dest, src)
      add $16, %esp 			# Removing the parameters
      
      movl %ebp, %esp			# Restoring the stack pointer to its original state
      popl %ebp				# Restoring the base pointer to its original state
      ret

      base:				# If basecase (num = 1) is reached
         #### PRINTING THE DESIRED MOVE ####
	 movl $4, %eax						# Syscall write
	 movl $1, %ebx						# Write to STDOUT
	 movl $out_string, %ecx 				# Location of the write buffer
	 movl $(out_string_end - out_string), %edx 		# Size of the buffer
	 int $0x80

	 movl $4, %eax
	 movl $1, %ebx
	 movl 12(%ebp), %ecx					# Location of the source tower label
	 movl $1, %edx						# Print only one character
	 int $0x80

         movl $4, %eax						# Syscall write
	 movl $1, %ebx						# Write to STDOUT
	 movl $to, %ecx 					# Location of the write buffer
	 movl $(to_end - to), %edx		 		# Size of the buffer
	 int $0x80

         movl $4, %eax
	 movl $1, %ebx
	 movl 16(%ebp), %ecx					# Location of the destination tower label
	 movl $1, %edx						# Print only one character
	 int $0x80

         movl $4, %eax						# Syscall write
	 movl $1, %ebx						# Write to STDOUT
	 movl $period, %ecx 					# Location of the write buffer
	 movl $(period_end - period), %edx		 	# Size of the buffer
	 int $0x80

	 movl %ebp, %esp					# Restoring the stack pointer
	 popl %ebp						# Restoring the base pointer
	 ret
