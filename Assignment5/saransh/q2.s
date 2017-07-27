# Program for q2
# q2.c uses an undefined function tolower, which takes a character as input and returns a character.
# strcmp is a standard string.h function which returns 0 when the two arguments exactly match.
# Our aim is to make sure that no 'if' branch is entered, i.e. the conditions evaluate to 0 in each case.
# This means that we must make sure that the arguments for strcmp match EXACTLY.
# Therefore, we need to define the tolower function in assembly such that it returns the capitalized character if given a lowercase character.

.section .data				# Empty, no data needed
.section .text
.globl tolower				# tolower should be callable globally

.type tolower, @function		# tolower is a function

tolower:
   pushl %ebp				# Save the value of %ebp on the stack
   movl %esp, %ebp			# Save the value of the stack pointer in %ebp
   movb 8(%ebp), %al			# Move the parameter to the register %al (since parameters are passed as 4 bytes, using the lowest byte)
   cmpb $97, %al 			# Compare the given character with the ascii value of 'a'
   jl return				# If the character is below 'a', return as it is
   subb $32, %al			# Subtract the value 'a' - 'A' to the parameter to make it uppercase
   return:
      movl %ebp, %esp			# Restore the stack pointer
      popl %ebp				# Restore the base pointer
      ret				# Return with the capitalized letter (if possible) in %al
