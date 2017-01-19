	.text
	.file	"fac_it.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	orr	w8, wzr, #0x1
	str	w0, [sp, #12]
	str	w8, [sp, #8]
.LBB0_1:                                // %while.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	cmp	 w8, #1                 // =1
	b.ne	.LBB0_2
	b	.LBB0_3
.LBB0_2:                                // %while.body
                                        //   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	mul	 w8, w9, w8
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	movn	w9, #0
	add	 w8, w8, w9
	str	w8, [sp, #12]
	b	.LBB0_1
.LBB0_3:                                // %while.end
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
	movz	w0, #0x64
	movz	w8, #0
	stur	w8, [x29, #-4]
	bl	fac
	str	w0, [sp, #8]
	ldr	w0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	main, .Ltmp2-main


	.ident	"clang version 3.5.0 "
