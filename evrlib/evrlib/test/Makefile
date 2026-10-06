test: test.asm
	nasm -f elf64 test.asm
	gcc -no-pie test.o -L. -levrlib -o test