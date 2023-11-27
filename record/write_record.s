.include "linux.s"
.include "record_def.s"

.section .data
record1:
	.ascii "kirin\0"
	.rept 34
	.byte 0
	.endr

	.ascii "zhu\0"
	.rept 36
	.byte 0
	.endr

	.ascii "Nanjing\0"
	.rept 232
	.byte 0
	.endr 

	.long 22

record2:
	.ascii "kiri2\0"
	.rept 34
	.byte 0
	.endr

	.ascii "zh2\0"
	.rept 36
	.byte 0
	.endr

	.ascii "Nanjin2\0"
	.rept 232
	.byte 0
	.endr 

	.long 23

file_name:
	.ascii "test.txt\0"

.section .text
.global _start, write_record
_start:
	movl %esp, %ebp
	subl $4, %esp

	movl $SYS_OPEN, %eax
	movl $file_name, %ebx
	movl $0101, %ecx
	movl $0776, %edx
	int $LINUX_SYSCALL
	movl %eax, -4(%ebp)

	pushl -4(%ebp) 
	pushl $record1
	call write_record
	addl $8, %esp

	movl %eax, %ebx
	movl $SYS_EXIT, %eax
	int $LINUX_SYSCALL

write_record:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_WRITE, %eax
	movl 12(%ebp), %ebx
	movl 8(%ebp), %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL

	mov %ebp, %esp
	popl %ebp
	ret

