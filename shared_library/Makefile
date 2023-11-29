# Makefile

FILENAME ?= default
COMMON := linux.s write_new_line.s count_chars.s

SHARED_LIBRARY_NAME:= file record
SHARED_LIBRARY := $(patsubst %, lib%.so, $(SHARED_LIBRARY_NAME))
OBJECT_FILE := $(patsubst %, %.o, $(SHARED_LIBRARY_NAME))

all: test_record

build_obj: $(OBJECT_FILE) 
build_so: build_obj $(SHARED_LIBRARY) 

lib%.so: %.o
	ld -g -m elf_i386 -shared -o $@ $<

%.o: %.s
	as -g --32 -o $@ $<
	
test_record: test_record.o build_so
	ld -m elf_i386 -dynamic-linker /lib/ld-linux.so.2 \
	   -o test_record  -L. -lfile -lrecord test_record.o

test_record.o: test_record.s $(BASE)
	as --32 -g -o test_record.o test_record.s

clean:
	find . -maxdepth 1 -type f ! -name 'Makefile' ! -name '*.s' -delete

