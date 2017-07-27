# Program to reverse an input string

.section .data
input_str:
  .ascii "Hello World"
input_str_end:

.section .text
.globl _start

_start:
  call reverse_string				# Call the reverse string function
  jmp print_rev					# After the subroutine returns, print the reversed string

  reverse_string:
    movl $input_str, %eax			# %eax stores the left pointer/left index for the string
    movl $input_str_end, %ebx			# %ebx stores the right pointer/right index for the string
    decl %ebx					# To make %ebx point to the last character in the string instead of the end of string
    cmpl %eax, %ebx
    je return					# Handling the case when the input string is just one character

    exchange_loop:				# Loop to reverse the string by exchanging the values at the left and right pointer
    xchgb (%eax), %cl				# Exchange the value (1 byte ascii) at location pointed by %eax and the register %cl (8 bit)
    xchgb %cl, (%ebx)				# Exchange the value in %cl and the value at the location pointed by %ebx
    xchgb (%eax), %cl				# Again exchange %cl and (%eax). This completes the exchange operation
    incl %eax					# Increment %eax to go further
    decl %ebx					# Decrement %ebx to go back 
    cmpl %eax, %ebx				# Check if the pointers are same or have crossed over
    jle return					# If they are the same or they crossed over, return
    jmp exchange_loop				# Else keep reversing

    return:
    	ret

  print_rev:
  movl $4, %eax 				# Syscall write
  movl $1, %ebx					# To print at stdout
  movl $input_str, %ecx				# Location of the (now reversed) string
  movl $(input_str_end - input_str), %edx	# Size of the buffer
  int $0x80
  
  ### EXIT CALL ###

  movl $1, %eax					# Syscall exit
  movl $0, %ebx
  int $0x80
