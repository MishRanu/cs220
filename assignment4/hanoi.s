
	
  .section  .data
dig:
	.ascii "0"

str1:
	.ascii "Move from "
str1_end:

str2:
	.ascii " to "
str2_end:

nl:
	.ascii ".\n"
nl_end:


num:
	.long 4
s:
	.ascii "A"	

m:
	.ascii "C"

e:
	.ascii "B"


.section  .text

 .globl  _start

_start:

	movl num,%edi
	movl $s,%eax
	movl $e,%ebx
	movl $m,%ecx
	movl $0,%ebp
	pushl %edi
	pushl %ecx
	pushl %ebx	
	pushl %eax
	pushl %ebp
	movl %esp,%ebp
	call hanoi
	jmp exit
 
hanoi:

        cmpl $1, 16(%ebp)               # n <= 0
        je   print                # if not,go do a recursive call
	decl 16(%ebp)
	pushl 16(%ebp)
	incl 16(%ebp)
	pushl 8(%ebp)
	pushl 12(%ebp)
	pushl 4(%ebp)
	pushl %ebp
	movl %esp,%ebp
	call hanoi
	
	popl  %ebp


	popl %eax
	popl %eax
	popl %eax
	popl %edi

	
	call print
		
	pushl %edi
	pushl 4(%ebp)
	pushl 8(%ebp)
	pushl 12(%ebp)
	pushl %ebp
	movl %esp,%ebp
	call hanoi
	
	popl  %ebp
	
	popl %eax
	popl %eax
	popl %eax
	popl %edi
	
        ret



print:
			
	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $str1, %ecx
	  movl $(str1_end-str1), %edx # Size of the buffer
	  int $0x80

	
	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl 4(%ebp),%ecx
	  movl $1, %edx # Size of the buffer
	  int $0x80

	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $str2, %ecx
	  movl $(str2_end-str2), %edx # Size of the buffer
	  int $0x80
	  
	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl 8(%ebp),%ecx
	  movl $1, %edx # Size of the buffer
	  int $0x80

	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $nl, %ecx
	  movl $(nl_end-nl), %edx # Size of the buffer
	  int $0x80


	
	 
	  ret
	


exit:
          movl $1, %eax
 	  movl $0, %ebx				# SYSCALL exit
   	  int $0x80	
