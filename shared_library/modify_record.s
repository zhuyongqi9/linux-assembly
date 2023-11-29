.include "linux.s"
.include "record_def.s"
.include "count_chars.s"
.include "write_new_line.s"

.section .data
inputfile: .ascii "test.txt\0"
outputfile: .ascii "modified.txt\0"

.section .bss
.lcomm record_buffer RECORD_SIZE

.section .text
.global _start

_start:
	movl %esp, %ebp
	subl $8, %esp

open_inputfile:
	movl $SYS_OPEN, %eax
	movl $inputfile, %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
store_inputfd:
	movl %eax, -4(%ebp)

open_outputfile:
	movl $SYS_OPEN, %eax
	movl $outputfile, %ebx
	movl $0101, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
store_outputfd:
	movl %eax, -8(%ebp)
	
	pushl -4(%ebp)
	pushl -8(%ebp)
	call modify_loop
	movl $1, %eax
	int $LINUX_SYSCALL

modify_loop:
	pushl %ebp
	movl %esp, %ebp	

modify_loop_start:
	pushl 12(%ebp)
	call read_record	
	addl $4, %esp
	cmpl $0, %eax	
	jle modify_ret

	addl $20, record_buffer+320
	
	pushl 8(%ebp)
	call write_record	
	addl $4, %esp
	jmp modify_loop_start


read_record:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_READ, %eax
	movl 8(%ebp), %ebx 
	movl $record_buffer, %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp	
	popl %ebp
	ret

write_record:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_WRITE, %eax
	movl 8(%ebp), %ebx 
	movl $record_buffer, %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp	
	popl %ebp
	ret

modify_ret:
	movl %ebp, %esp	
	popl %ebp
	ret





	
	
