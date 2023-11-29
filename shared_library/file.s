.include "linux.s"

.section .data

.section .text
.global open_read, open_close, close
# arg0: filepath
open_read:
	pushl %ebp
	movl %esp, %ebp
	
	movl $SYS_OPEN, %eax
	movl 8(%ebp), %ebx
	movl $0, %ecx
	movl $0666, %edx
	
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
	
	movl %ebp, %esp
	popl %ebp
	ret

# arg0: filedescriptor
close:
	pushl %ebp
	movl %esp, %ebp
	
	movl $SYS_CLOSE, %eax
	movl 8(%ebp), %ebx
	
	movl %ebp, %esp
	popl %ebp
	ret
	
