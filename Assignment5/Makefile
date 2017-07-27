all:	q1 q2 q3

q1: q1_c.c q1_ass.s
	gcc -m32 q1_c.c q1_ass.s -o q1
	
q2: q2.c q2_s.s
	gcc -m32 q2.c q2_s.s -o q2
	

q3: 
	gcc -m32 -c q3_c.c -o q3_c.o
	ld q3.o q3_c.o -o q3_ans -m elf_i386 -lc -dynamic-linker /lib/ld-linux.so.2
	
.PHONY: clean

clean:
	rm -rf q1 q2 q3_ans q3_c.o 
