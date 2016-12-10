	.text
	.file	"fac_it.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:
	sub	sp, sp, #16             // =16
	orr	w8, wzr, #0x1
	str	w0, [sp, #12]
	str	w8, [sp, #8]
.LBB0_1:                                // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp		w8, #1          // =1
	b.eq	.LBB0_3
// BB#2:                                //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	mul		w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	sub	w8, w8, #1              // =1
	str	w8, [sp, #12]
	b	.LBB0_1
.LBB0_3:
	ldr	w0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Lfunc_end0:
	.size	fac, .Lfunc_end0-fac

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	movz	w0, #0xa
	stur	wzr, [x29, #-4]
	bl	fac
	mov	 w8, wzr
	str	w0, [sp, #8]
	mov	 w0, w8
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main


	.ident	"Apple LLVM version 8.0.0 (clang-800.0.42.1)"
	.section	".note.GNU-stack","",@progbits
