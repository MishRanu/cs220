# Function to find the maximum number in an array of integers

.section .data				# Empty data section since the data will handled by the C program

.section .text
.globl find_max 			# Since we want the function to be called by other programs

.type find_max, @function		# find_max is a function

find_max:
   pushl %ebp				# Saving the base pointer
   movl %esp, %ebp			# Storing the value of the stack pointer into the base pointer
   movl 8(%ebp), %ebx			# Storing the size of the input array in %ebx (n)
   movl $0, %edi			# Initializing %edi to store the index of the array while scanning
   movl 12(%ebp), %ecx			# %ecx stores the second parameter, which is the base address of the input array
   movl (%ecx), %eax			# Store the first element of the array (a[0]) in %eax (eax stores max)

   loop:				# Loop to scan the entire array
      incl %edi				# Increment %edi to go to the next index
      cmpl %edi, 8(%ebp)		# Compare the index with n
      je return				# If %edi == n, return
      cmpl %eax, (%ecx, %edi, 4)	# compare max and a[i]
      jle loop				# if a[i] <= max, then just go to the next iteration
      movl (%ecx, %edi, 4), %eax	# if max < a[i] then max = a[i]
      jmp loop				# Loop again

   return:
      movl %ebp, %esp			# Restore the stack pointer to its original value
      popl %ebp				# Restore the base pointer to its original value
      ret				# Return with return value in %eax
