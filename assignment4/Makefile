all: hanoi_sar prob2_sar coin_sar

hanoi_sar: hanoi_sar.s
	as -32 hanoi_sar.s -o hanoi_sar.o
	ld hanoi_sar.o -m elf_i386 -o hanoi_sar

hanoi_san: hanoi_san.s
	as -32 hanoi san.s -o hanoi_san.o
	ld hanoi_san.o -m elf_i386 -o hanoi_san

prob2_sar: prob2_sar.s
	as -32 prob2_sar.s -o prob2_sar.o
	ld prob2_sar.o -m elf_i386 -o prob2_sar


ack_san: ack_san.s
	as -32 ack_san.s -o ack_san.o
	ld ack_san.o -m elf_i386 -o ack_san

coin_sar: coin_sar.s
	as -32 coin_sar.s -o coin_sar.o
	ld coin_sar.o -m elf_i386 -o coin_sar

.PHONY: clean

clean:
	rm -rf hanoi_sar.o prob2_sar.o hanoi_sar prob2_sar coin_sar.o coin_sar
