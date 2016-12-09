	.text
	.file	"fac_it.ll"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	orr	w8, wzr, #0x1
	stp	w8, w0, [sp, #8]
	b	.LBB0_2
.LBB0_1:                                // %while.body
                                        //   in Loop: Header=BB0_2 Depth=1
	ldp	w9, w8, [sp, #8]
	ldr	w10, [sp, #12]
	mul	 w8, w9, w8
	sub	w9, w10, #1             // =1
	stp	w8, w9, [sp, #8]
.LBB0_2:                                // %while.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_1
// BB#3:                                // %while.end
	ldr	w0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp1:
	.size	fac, .Ltmp1-fac

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	stur	wzr, [x29, #-4]
	movz	w0, #0xa
	bl	fac
	str	w0, [sp, #8]
	mov	 w0, wzr
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	main, .Ltmp2-main


	.ident	"clang version 3.5.0 "
