.section .data
str: .ascii "hello, world\n\0"

.section .text
.global _start
_start:
	pushl $str
	call printf
	movl $1, %eax
	int $0x80
