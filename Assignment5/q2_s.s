.section .data 

.section .text 

.globl _start 

.globl tolower

.type tolower, @function			#Made this function since it appears in the C code.

tolower:
	popl %ebx					#Store return address to C program in %ebx
 	popl %eax					#Store character argument of tolower function ini %eax
	cmpl $97,%eax				#97 is the ascii value 'a'
	jge set_exit					#if character was >= 'a', i.e., if it is a lower case letter, goto set_exit
	pushl %eax					#Push upper case character into stack
	pushl %ebx					#Push return address back into the stack and return to C program
	ret

set_exit:
	subl $32,%eax				#Convert it into an uppercase character('A'=65)
	pushl %eax					#Push character into stack
	pushl %ebx					#Push return address back into the stack and return to C program
	
	ret
