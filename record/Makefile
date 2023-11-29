# Makefile

FILENAME ?= default
COMMON=linux.s write_new_line.s count_chars.s

$(FILENAME): $(FILENAME).o
	ld -m elf_i386 -g -o $(FILENAME) $(FILENAME).o

$(FILENAME).o: $(FILENAME).s $(COMMON)
	as -g --32 -o $(FILENAME).o $(FILENAME).s 

gdb: $(FILENAME)
	gdb $(FILENAME)
	

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' -delete
