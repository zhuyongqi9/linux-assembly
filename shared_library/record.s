.include "../base_file/linux.s"
.include "record_def.s"

.section .data

.section .text
.global read_record, write_record 
.type read_record, @function
.type write_record, @function

# arg0 fd
# arg1 buffer addr
read_record:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_READ, %eax
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp
	popl %ebp
	ret

# arg0 fd
# arg1 buffer addr
write_record:
	pushl %ebp
	movl %esp, %ebp

	movl $SYS_WRITE, %eax
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	movl $RECORD_SIZE, %edx
	int $LINUX_SYSCALL

	movl %ebp, %esp
	popl %ebp
	ret


