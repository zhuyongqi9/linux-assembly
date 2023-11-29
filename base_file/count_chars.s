.global count_chars

.type count_chars, @function
count_chars:
	pushl %ebp
	movl %esp, %ebp

	movl $0, %ecx
	movl 8(%ebp), %ebx

count_chars_loop:
	cmpb $0, (%ebx, %ecx, 1)
	je count_ret
	incl %ecx
	jmp count_chars_loop

count_ret:
	movl %ecx, %eax
	movl %ebp, %esp
	popl %ebp
	ret

