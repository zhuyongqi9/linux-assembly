.include "linux.s"
.include "record_def.s"
.include "count_chars.s"
.include "write_new_line.s"
.section .data
filename:
	.ascii "test.txt\0"

.section .bss
.lcomm record_buffer RECORD_SIZE

.section .text
.global _start
_start:
	movl %esp, %ebp
	subl $4, %esp
	movl $SYS_OPEN, %eax
	movl $filename, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	movl %eax, -4(%ebp)

read_record_loop:
	movl $SYS_READ, %eax
	movl -4(%ebp), %ebx
	movl $record_buffer, %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL
	cmpl $0, %eax
	jle exit
	pushl -4(%ebp)
	call read_record
	addl $4,  %esp
	jmp read_record_loop

read_record:
	pushl %ebp
	movl %esp, %ebp

	pushl $record_buffer	
	call count_chars
	movl %eax, -4(%ebp)

	movl $SYS_WRITE, %eax
	movl $STDOUT, %ebx 
	movl $record_buffer, %ecx
	movl -4(%ebp), %edx
	int $LINUX_SYSCALL
	pushl $STDOUT
	call write_newline	
	addl $4, %esp

	movl %ebp, %esp	
	popl %ebp
	ret

exit:
	movl $0, %ebx
	movl $1, %eax
	int $LINUX_SYSCALL





	
	
