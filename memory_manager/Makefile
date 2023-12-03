# Makefile

FILE ?= default

all: test_memory_manager
	@echo "add ld config"
	cp asm_memory_manager.conf /etc/ld.so.conf.d/
	ldconfig

test_memory_manager: test_memory_manager.o libmemory_manager.so
	ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 \
	   -o test_memory_manager -L. -lmemory_manager  test_memory_manager.o

test_memory_manager.o: test_memory_manager.s file.s
	as --32 -g -o test_memory_manager.o test_memory_manager.s

libmemory_manager.so: memory_manager.o
	ld -g -m elf_i386 -shared -o libmemory_manager.so memory_manager.o

memory_manager.o: memory_manager.s
	as --32 -g -o memory_manager.o memory_manager.s

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' ! -name '*.conf' -delete 


