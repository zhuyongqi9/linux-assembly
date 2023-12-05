.include "integer2string.s"
.include "base_file/linux.s"
.include "base_file/write_new_line.s"

.section .data
buf: .ascii "\0\0\0\0\0\0\0"

.section .text
.global _start

_start:
	pushl $buf	
	pushl $123
	call integer2string
	addl $8, %esp
	
	movl $SYS_WRITE, %eax	
	movl $STDOUT, %ebx
	movl $buf, %ecx
	movl $6, %edx
	int $LINUX_SYSCALL	
	
	pushl $STDOUT
	call write_newline
	addl $4, %esp

	movl $1, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL
