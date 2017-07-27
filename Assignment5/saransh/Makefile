all: q1 q2 q3

q1: q1.c q1.s
	gcc -m32 q1.c q1.s -o q1

q2: q2.c q2.s
	gcc -m32 q2.c q2.s -o q2

q3: q3.c
	gcc -m32 -c q3.c -o q3_c.o
	ld q3.o q3_c.o -o q3 -m elf_i386 -lc -dynamic-linker /lib/ld-linux.so.2

.PHONY: clean

clean:
	rm -f q1 q2 q3_c.o q3
