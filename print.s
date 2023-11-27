.section .data
str:
	.string "Hello world\n"

.section .text
.global _start

.equ SYS_WRITE, 4
_start:
	movl $SYS_WRITE, %eax
	movl $1, %ebx
	movl $str, %ecx
	movl $, %edx
	int $0x80

	movl $0, %ebx
	movl $1, %eax
	int $0x80

