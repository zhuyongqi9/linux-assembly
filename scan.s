.include "linux.s"
.section .data
.equ BUFSIZE, 1024
.lcomm buf BUFSIZE
filename: .ascii "./input.txt\0"
flag: .long 0

.section .text
.global _start

.equ STDINPUT, 0 
_start:
	movl %esp, %ebp
	subl $4, %esp
open_file:
	movl $SYS_OPEN, %eax
	movl $filename, %ebx
	movl $1101, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	movl %eax, -4(%ebp)

read_loop:
	movl $SYS_READ, %eax
	movl $STDINPUT, %ebx
	movl $buf, %ecx
	movl $BUFSIZE, %edx 
	int $LINUX_SYSCALL
	cmpl $0, %eax
	jle exit

	movl %eax, -8(%ebp)
	decl %eax
	cmpl $'\n', buf(, %eax, 1)
	movl $1, flag

	movl $SYS_WRITE, %eax
	movl -4(%ebp), %ebx
	movl $buf, %ecx
	movl -8(%ebp), %edx
	int $LINUX_SYSCALL

	cmpl $1, flag	
	jne read_loop

exit:
	movl $1, %eax
	int $LINUX_SYSCALL
	



