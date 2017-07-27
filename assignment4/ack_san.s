
	
  .section  .data
digit:
	.ascii "0"

m:
	.long 1
n:
	.long 0



.section  .text

 .globl  _start

_start:
	movl $0,%ebp
	movl m,%ebx
	movl n,%eax
	pushl %ebx	
	pushl %eax
	pushl %ebp
	movl %esp,%ebp
	
	call ackermann
	
	movl $0, %edi
	
	jmp start_loop
                          
   start_loop:
	
	movl $10, %ebx
	movl $0, %edx
	divl %ebx 
	pushl %edx
	incl %edi
        cmpl $0, %eax
  	je print
        jmp start_loop


  print:
        cmpl $0, %edi
	je loop_exit
	movl $'0', digit
	decl %edi
	popl %ecx
	addl %ecx, digit
	
	 movl $4, %eax                   # 4 is the system call number
	 movl $1, %ebx                   # 1 stands for stdout
	 movl $digit, %ecx
	 movl $1, %edx # Size of the buffer
	 int $0x80
	 jmp print
		

 	
  loop_exit:
	  movl $'\n', digit
 	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $digit, %ecx
	  movl $1, %edx # Size of the buffer
	  int $0x80
          movl $1, %eax
          movl $0, %ebx				# SYSCALL exit
          int $0x80

 
ackermann:	

        cmpl $0, 4(%ebp)               # m <= 0
        je   base                # if not,go do a recursive call
	cmpl $0, (%ebp)
	je base2
	
	jne A 
	pushl %esi
        ret

A:
	popl %esi
	
	popl %ebx
	popl %eax
	decl %ebx
	pushl %ebx
	incl %ebx
	decl %eax
	pushl %ebx
	pushl %eax
	movl %esp,%ebp
	call ackermann
	
	call ackermann
	pushl %esi
	ret
base:
	
	popl %esi
	
	movl (%ebp), %eax
	addl $1, %eax
	
	popl %ecx
	
	popl %ecx

	pushl %eax
        movl %esp,%ebp

	pushl %esi
	ret

base2:

	
	popl %esi

	popl %eax
	
	popl %eax
	
	popl %ebx

	decl %ebx
	pushl %ebx
	movl  $1,%ecx
	pushl %ecx
	movl %esp, %ebp
	pushl %esi
	call ackermann
		
	ret


	
	


exit:
          movl $1, %eax
 	  movl $0, %ebx				# SYSCALL exit
   	  int $0x80	

