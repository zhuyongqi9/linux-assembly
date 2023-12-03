.include "../base_file/linux.s"
.section .data
heap_begin: .long 0
current_break: .long 0
flag: .long 0

.equ HEADER_SIZE, 8
.equ HEADER_AVAIL_OFFSET, 0
.equ HEADER_SIZE_OFFSET, 4 

.equ UNAVAILABLE, 0
.equ AVAILABLE, 1

.section .text
.global allocate_init
.type allocate_init, @function
allocate_init:
	pushl %ebp
	movl %esp, %ebp
	movl $SYS_BRK, %eax
	movl $0, %ebx
	int $LINUX_SYSCALL
	
	movl %eax, heap_begin
	movl %eax, current_break

	movl $1, flag
	movl %ebp, %esp
	popl %ebp
	ret

.global allocate
.type allocate, @function
allocate:
	pushl %ebp
	movl %esp, %ebp

	cmpl $1, flag
	je allocate_begin
	call allocate_init

allocate_begin:
	movl 8(%ebp), %ecx
	movl heap_begin, %eax

allocate_loop:
	cmpl %eax, current_break 
	je move_break
	
	cmpl $UNAVAILABLE, HEADER_AVAIL_OFFSET(%eax)
	je next_location

	cmpl HEADER_SIZE_OFFSET(%eax), %ecx
	jg next_location
	
	movl $AVAILABLE, HEADER_AVAIL_OFFSET(%eax)
	addl $HEADER_SIZE, %eax
	movl %ebp, %esp
	popl %ebp
	ret

next_location:
	addl HEADER_SIZE_OFFSET(%eax), %eax
	addl $HEADER_SIZE, %eax
	jmp allocate_loop

move_break:
	pushl %eax
	pushl %ecx

	addl $HEADER_SIZE, %ecx 
	addl current_break, %ecx
	movl $SYS_BRK, %eax
	movl %ecx, %ebx
	int $LINUX_SYSCALL
	movl %eax, current_break 

	popl %ecx
	popl %eax

	movl $UNAVAILABLE, HEADER_AVAIL_OFFSET(%eax)
	movl %ecx, HEADER_SIZE_OFFSET(%eax)

	addl $HEADER_SIZE, %eax
	movl %ebp, %esp
	popl %ebp
	ret

.global deallocate
.type deallocate, @function
deallocate:
	pushl %ebp			
	movl %esp, %ebp
	
	movl 8(%ebp), %eax
	subl $HEADER_SIZE, %eax
	movl $AVAILABLE, HEADER_AVAIL_OFFSET(%eax)

	movl %ebp, %esp
	popl %ebp
	ret




