	.text
	.file	"fac_rec.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	stur	w0, [x29, #-4]
	ldur	w0, [x29, #-4]
	cmp		w0, #1          // =1
	b.le	.LBB0_2
// BB#1:
	ldur	w8, [x29, #-4]
	ldur	w9, [x29, #-4]
	sub	w0, w9, #1              // =1
	str	w8, [sp, #8]            // 4-byte Folded Spill
	bl	fac
	ldr	w8, [sp, #8]            // 4-byte Folded Reload
	mul		w8, w8, w0
	str	w8, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_2:
	orr	w8, wzr, #0x1
	str	w8, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_3:
	ldr	w0, [sp, #4]            // 4-byte Folded Reload
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
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
