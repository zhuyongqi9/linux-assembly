.include "error_exit.s"
.section .data
code: .ascii "200\0"
msg: .ascii "this is an error message\0"

.section .text
.global _start
_start:
	pushl $code
	pushl $msg
	call error_exit
