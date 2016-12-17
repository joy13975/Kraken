	.text
	.file	"fac_rec.c"
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	stur	w0, [x29, #-4]
	ldur	w0, [x29, #-4]
	cmp	 w0, #1                 // =1
	b.gt	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %cond.true
	ldur	w8, [x29, #-4]
	ldur	w9, [x29, #-4]
	orr	w10, wzr, #0x1
	subs	 w0, w9, w10
	str	w8, [sp, #8]            // 4-byte Folded Spill
	bl	fac
	ldr	w8, [sp, #8]            // 4-byte Folded Reload
	mul	 w0, w8, w0
	str	w0, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_2:                                // %cond.false
	orr	w8, wzr, #0x1
	str	w8, [sp, #4]            // 4-byte Folded Spill
	b	.LBB0_3
.LBB0_3:                                // %cond.end
	ldr	w0, [sp, #4]            // 4-byte Folded Reload
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
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
	movz	w0, #0xa
	movz	w8, #0
	stur	w8, [x29, #-4]
	bl	fac
	str	w0, [sp, #8]
	ldr	w0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp1:
	.size	main, .Ltmp1-main


	.ident	"clang version 3.5.0 "
