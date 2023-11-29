.include "linux.s"
.section .data
str: .ascii "my name is %s, I'm %d years old\n\0"
name: .ascii "yongqi"
age: .long 22

.section .text
.global _start
_start:
	pushl age # not use $, because we need value instead of addr
	pushl $name
	pushl $str
	call printf

	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL
