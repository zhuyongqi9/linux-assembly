# Makefile

FILE ?= default
BASE=linux.s

$(FILE): $(FILE).o
	ld -dynamic-linker /lib/ld-linux.so.2 -m elf_i386 -g -o $(FILE) $(FILE).o -lc

$(FILE).o: $(FILE).s $(BASE)
	as -g --32 -o $(FILE).o $(FILE).s

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' -delete

