# Makefile

FILENAME ?= default

$(FILENAME): $(FILENAME).o
	ld -m elf_i386 -g -o $(FILENAME) $(FILENAME).o

$(FILENAME).o: $(FILENAME).s
	as -g --32 -o $(FILENAME).o $(FILENAME).s

clean:
	rm -f *.o 
