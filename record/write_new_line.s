.include "linux.s"

.global write_newline 

.section .data
newline:
	.ascii "\n"

.type write_newline, @function
write_newline:
	push %ebp
	movl %esp, %ebp

	movl SYS_WRITE, %eax 
	movl 8(%ebp), %ebx
	movl $ascii, %ecx
	movl $1, %edx

	movl %ebp, %esp
	popl %ebp
	ret
