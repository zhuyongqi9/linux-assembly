.include "linux.s"
.include "count_chars.s"
.include "write_new_line.s"

.equ ERR_CODE, 12
.equ ERR_MSG, 8

.section .text
.global error_exit
.type error_exit, @function
error_exit:
	pushl %ebp
	movl %esp, %ebp

	movl ERR_CODE(%ebp), %ecx
	pushl %ecx
	call count_chars
	movl %eax, %edx
	popl %ecx
	movl $SYS_WRITE, %eax 
	movl $STDERR, %ebx
	int $LINUX_SYSCALL
	call write_newline
	
	movl ERR_MSG(%ebp), %ecx
	pushl %ecx
	call count_chars
	movl %eax, %edx
	popl %ecx
	movl $SYS_WRITE, %eax 
	movl $STDERR, %ebx
	int $LINUX_SYSCALL
	call write_newline

	movl $1, %ebx
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL
