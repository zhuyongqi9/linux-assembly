.include "integer2string.s"
.include "base_file/linux.s"
.include "base_file/write_new_line.s"

.section .data
buf: .ascii "\0\0\0\0\0\0\0"

.section .text
.global _start

_start:
	movl $10000, %edi
call_loop:
	cmpl $0, %edi 
	je ret
	pushl %edi
	call call_function
	popl %edi
	decl %edi
	jmp call_loop

ret:
	movl $1, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL

call_function:
	pushl %ebp
	movl %esp, %ebp

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

	movl %ebp, %esp
	popl %ebp
	ret
