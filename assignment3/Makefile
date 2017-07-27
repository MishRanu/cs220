all: printnum check_prime strrev hanoi

printnum: printnum.s
	as -32 printnum.s -o printnum.o
	ld printnum.o -m elf_i386 -o printnum

check_prime: check_prime.s
	as -32 check_prime.s -o check_prime.o
	ld check_prime.o -m elf_i386 -o check_prime

strrev: strrev.s
	as -32 strrev.s -o strrev.o
	ld strrev.o -m elf_i386 -o strrev

hanoi:  hanoi.s
	as -32 hanoi.s -o hanoi.o
	ld hanoi.o -m elf_i386 -o hanoi


.PHONY: clean

clean:
	rm -rf printnum.o check_prime.o printnum check_prime strrev.o strrev
