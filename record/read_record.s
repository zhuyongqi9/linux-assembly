.include "linux.s"
.include "record_def.s"
.include "count_chars"
.section .data
file_name:
	.ascii "test.txt\0"

.section .bss
.lcomm record_buffer RECORD_SIZE

.global _start
_start:
	subl %esp, 4

	movl $SYS_OPEN, %eax
	movl $file_name, %ebx
	movl $record_buffer, %ecx
	movl %RECORD_SIZE, %edx
	int LINUX_SYSCALL
	movl %eax, -4(%ebp) 

	pushl %ecx
	call count_chars
	addl $4, %esp
	
	