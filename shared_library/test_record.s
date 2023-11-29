.include "linux.s"
.include "count_chars.s"
.include "record_def.s"

.section .data
file: .ascii "./data.txt\0"
data1:
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

.section .bss
.lcomm buf RECORD_SIZE 

.section .text
.global _start
_start:
	movl %esp, %ebp
	subl $4, %esp

test_write_record:
	pushl $file
	call open_write
	movl %eax, -4(%ebp)
	addl $4, %esp

	pushl $data1 
	pushl -4(%ebp)
	call write_record
	addl $8, %esp

	pushl -4(%ebp)
	call close 
	addl $4, %esp

test_read_record:
	pushl $file
	call open_read
	movl %eax, -4(%ebp)
	addl $4, %esp

	pushl $buf
	pushl -4(%ebp)
	call read_record
	addl $8, %esp

	pushl $buf
	call count_chars 
	addl $4, %esp
	movl %eax, %edx
	movl $SYS_WRITE, %eax
	movl $STDOUT, %ebx
	movl $buf, %ecx
	int $LINUX_SYSCALL

exit:
	movl $0, %ebx
	movl $1, %eax
	int $LINUX_SYSCALL


