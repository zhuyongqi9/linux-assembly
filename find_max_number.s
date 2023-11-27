.section .data
data_items:
	.long 1, 2, 100, 3, 2, 101


.section .text
.global _start
_start:
	movl $0, %edi
	movl data_items(, %edi, 4), %eax
	movl %eax, %ebx
	leal data_items+6, %ecx

start_loop:
	incl %edi
	leal data_items, %eax
	addl %edi, %eax
	cmpl %ecx, %eax
	je loop_exit

	movl data_items(, %edi, 4), %eax
	cmpl %ebx, %eax
	jle start_loop

	movl %eax, %ebx
	jmp start_loop

loop_exit:
	movl $1, %eax
	int $0x80