
  .section  .data
dig:
	.ascii "0"

str1:
	.ascii "Move from "
str1_end:

str2:
	.ascii "to "
str2_end:

nl:
	.ascii ".\n"
nl_end:


num:
	.long 29
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
	movb s,%al
	movb e,%bl
	movb m,%cl	
	call hanoi
 
hanoi:
	
        cmp     $0, %edi               # n <= 0
        je   print                    # if not, go do a recursive call
        ret


L1:
#	popl %al			#
#	popl %bl			# bl=m
#	popl %cl 			# cl=s
        pushl    %edi                    # save n on stack (also aligns %esp!)
        dec     %edi                    # n-1
        call    factorial               # factorial(n-1), result goes in %rax
        popl     %edi                    # restore n
        imul    %edi, %eax              # n * factorial(n-1), stored in %rax
        ret

print:
	  pushb %cl
	  pushb %bl
	  pushb %al
	 
	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout
	  movl $str1, %ecx
	  movl $(str1_end-str1), %edx # Size of the buffer
	  int $0x80

 	  movl $4, %eax                   # 4 is the system call number
	  movl $1, %ebx                   # 1 stands for stdout

	  movl $str1, %ecx
	  movl $(str1_end-str1), %edx # Size of the buffer
	  int $0x80	

 movl $1, %eax
    movl $0, %ebx				# SYSCALL exit
    int $0x80	
