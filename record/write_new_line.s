.include "linux.s"
.global write_newline 
.type write_newline, @function

.section .data
newline:
	.ascii "\n"

.section .text
write_newline:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_WRITE, %eax 
	movl 8(%ebp), %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp
	popl %ebp
	ret
