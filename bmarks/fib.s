	.text
	.file	"fib.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	movz	w0, #0x3c5, lsl #16
	movk	w0, #0xea2
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
