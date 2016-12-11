	.text
	.file	"add.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	adrp	x8, main.a
	add	x8, x8, :lo12:main.a
	movz	w9, #0
	str	w9, [sp, #12]
	ldr	 w0, [x8]
	add	sp, sp, #16             // =16
	ret
.Ltmp1:
	.size	main, .Ltmp1-main

	.type	main.a,@object          // @main.a
	.data
	.align	2
main.a:
	.word	1                       // 0x1
	.word	3                       // 0x3
	.word	5                       // 0x5
	.word	4                       // 0x4
	.word	2                       // 0x2
	.word	7                       // 0x7
	.word	5                       // 0x5
	.word	3                       // 0x3
	.word	1                       // 0x1
	.word	5                       // 0x5
	.size	main.a, 40


	.ident	"clang version 3.5.0 "
