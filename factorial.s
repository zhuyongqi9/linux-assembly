.section .data
.section .text
.global _start

_start:
	pushl $5
	call factorial 
	addl $4, %esp
	movl %eax, %ebx
	movl $1, %eax
	int $0x80

factorial:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp

	movl 8(%ebp), %ecx
	cmpl $1, %ecx
	je _factorial_return
	
	subl $1, %ecx
	pushl %ecx
	call factorial
	movl 8(%ebp), %ecx

	imull %eax, %ecx 

_factorial_return:
	movl %ecx, %eax
	movl %ebp, %esp
	popl %ebp
	ret

	