.section .data

.section .text

.globl _start

.globl findmax

.type findmax, @function

findmax:
	popl %ecx	#store c funtion call return address	
	popl %edx	# put %edx= n
	pushl %ecx	#store return address in stack again
	movl 4(%esp),%ecx
	movl (%ecx),%eax
	addl $4,%ecx
	decl %edx

	_start_loop:

	cmpl $0,%edx
	je exit
	movl (%ecx),%ebx
	addl $4,%ecx
	subl $1, %edx
	cmpl %ebx,%eax
	jle set
	
	jmp _start_loop
	
exit:
	popl  %ecx
	popl %edx
	pushl %ecx
	#popl %edx
	ret


set:
	movl %ebx,%eax
	jmp _start_loop


