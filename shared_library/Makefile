# Makefile

FILENAME ?= default
COMMON := linux.s write_new_line.s count_chars.s

SHARED_LIBRARY_NAME:= file record
SHARED_LIBRARY := $(patsubst %, %.so, $(SHARED_LIBRARY_NAME))
OBJECT_FILE := $(patsubst %, %.o, $(SHARED_LIBRARY_NAME))

build_obj: $(OBJECT_FILE) 
build_so: $(SHARED_LIBRARY)

%.so: %.o
	ld -g -m elf_i386 -shared -o $@ $<

%.o: %.s
	as -g --32 -o $@ $<
	
test_record: test_record.o
	ld -m elf_i386 -g -o test_record test_record.o

test_record.o: test_record.s
	ld -L . -dynamic-linker /lib/ld-linux.so.2 \
	   -o test_record.o -lfile -lrecord

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' -delete

