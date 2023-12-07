# Makefile

FILE ?= default

$(FILE): $(FILE).o
	ld -m elf_i386 -g -o $(FILE) $(FILE).o

$(FILE).o: $(FILE).s
	as -g --32 -o $(FILE).o $(FILE).s

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' ! -name '*.py' ! -name '*.c' -delete


