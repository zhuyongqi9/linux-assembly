.include "linux.s"
.section .data
str: .ascii "test\n\0"

.section .text
.global _start
_start:
	pushl $str
	call strlen

	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL
