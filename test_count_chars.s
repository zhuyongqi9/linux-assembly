.include "linux.s"
.include "count_chars.s"

.section .data
str0: .ascii "\0"
str1: .ascii "a\0"
str10: .ascii "1234567890\0"

success_msg: .ascii "all tests pass\n\0"
error_msg: .ascii "tests fail!\n\0"

.section .text
.global _start
_start:
	pushl $str0
	call count_chars
	addl $4, %esp
	cmpl $0, %eax
	jne error_exit

	pushl $str1
	call count_chars
	addl $4, %esp
	cmpl $1, %eax
	jne error_exit
	
	pushl $str10
	call count_chars
	addl $4, %esp
	cmpl $10, %eax
	jne error_exit

success_exit:
	movl $SYS_WRITE, %eax
	movl $STDOUT, %ebx
	movl $success_msg, %ecx
	movl $15, %edx
	int $LINUX_SYSCALL

	movl $0, %ebx
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL

error_exit:
	movl $SYS_WRITE, %eax
	movl $STDERR, %ebx
	movl $error_msg, %ecx
	movl $12, %edx
	int $LINUX_SYSCALL

	movl $1, %ebx
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL
