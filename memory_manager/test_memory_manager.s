.include "file.s"
.include "../base_file/linux.s"
.include "../base_file/count_chars.s"

.section .data
file_output: .ascii "test.txt\0"

.equ FD_INPUT, -4
.equ FD_OUTPUT, -8
.equ BUF, -12 

.section .text
.global _start
_start:
	movl %esp, %ebp
	subl $12, %esp

	pushl $20
	call malloc
	movl %eax, BUF(%ebp)
	addl $4, %esp

	movl $SYS_READ, %eax
	movl $STDIN, %ebx
	movl BUF(%ebp), %ecx
	movl $19, %edx
	int $LINUX_SYSCALL
	
	pushl $file_output
	call open_write
	movl %eax, FD_OUTPUT(%ebp)
	add $4, %esp

	pushl BUF(%ebp)
	call count_chars
	movl %eax, %edx
	addl $4, %esp

	movl $SYS_WRITE, %eax
	movl FD_OUTPUT(%ebp), %ebx
	movl BUF(%ebp), %ecx
	int $LINUX_SYSCALL
	
	pushl BUF(%ebp)
	call deallocate
	addl $4, %esp

	pushl $30
	call malloc
	addl $4, %esp

	pushl $20
	call malloc
	addl $4, %esp

	addl $4, %esp
	movl $0, %ebx
	movl $1, %eax
	int $LINUX_SYSCALL



