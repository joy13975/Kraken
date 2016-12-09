	.text
	.file	"fac_rec.ll"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16            // =16
	sub	sp, sp, #16             // =16
	str	w0, [sp, #12]
	cmp	 w0, #2                 // =2
	b.lt	.LBB0_2
// BB#1:                                // %cond.true
	ldr	w19, [sp, #12]
	sub	w0, w19, #1             // =1
	bl	fac
	mul	 w0, w19, w0
	b	.LBB0_3
.LBB0_2:
	orr	w0, wzr, #0x1
.LBB0_3:                                // %cond.end
	sub	sp, x29, #16            // =16
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
.Ltmp0:
	.size	fac, .Ltmp0-fac

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
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
