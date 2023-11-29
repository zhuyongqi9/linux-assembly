.include "../base_file/linux.s"

.section .data

.section .text
.global open_read, open_write, close
.type open_read, @function
.type open_write, @function
.type close, @function
# arg0: filepath
open_read:
	pushl %ebp
	movl %esp, %ebp
	
	movl $SYS_OPEN, %eax
	movl 8(%ebp), %ebx
	movl $0, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	
	movl %ebp, %esp
	popl %ebp
	ret

# arg0: filepath
open_write:
	pushl %ebp
	movl %esp, %ebp
	
	movl $SYS_OPEN, %eax
	movl 8(%ebp), %ebx
	movl $1101, %ecx
	movl $0666, %edx
	int $LINUX_SYSCALL
	
	movl %ebp, %esp
	popl %ebp
	ret

# arg0: filedescriptor
close:
	pushl %ebp
	movl %esp, %ebp
	
	movl $SYS_CLOSE, %eax
	movl 8(%ebp), %ebx
	int $LINUX_SYSCALL
	
	movl %ebp, %esp
	popl %ebp
	ret
	
