	.text
	.file	"sqrt.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI0_0:
	.xword	4554050699414489        // double 2.25E-308
.LCPI0_1:
	.xword	-9218817986155361319    // double -2.25E-308
	.text
	.globl	sqroot
	.align	2
	.type	sqroot,@function
sqroot:                                 // @sqroot
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	orr	x8, xzr, #0x1
	scvtf	s1, x8
	orr	x8, xzr, #0x3
	scvtf	s2, x8
	str	s0, [sp, #24]
	ldr	s0, [sp, #24]
	fdiv	s0, s0, s2
	str	s0, [sp, #20]
	str	s1, [sp, #12]
	ldr	s0, [sp, #24]
	fcmp	s0, #0.0
	b.ls	.LBB0_1
	b	.LBB0_2
.LBB0_1:                                // %if.then
	movz	x8, #0
	scvtf	s0, x8
	str	s0, [sp, #28]
	b	.LBB0_8
.LBB0_2:                                // %if.end
	b	.LBB0_3
.LBB0_3:                                // %do.body
                                        // =>This Inner Loop Header: Depth=1
	orr	x8, xzr, #0x2
	scvtf	s0, x8
	ldr	s1, [sp, #20]
	str	s1, [sp, #16]
	ldr	s1, [sp, #20]
	ldr	s2, [sp, #24]
	ldr	s3, [sp, #20]
	fdiv	s2, s2, s3
	fadd	s1, s1, s2
	fdiv	s0, s1, s0
	str	s0, [sp, #20]
	ldr	s0, [sp, #20]
	ldr	s1, [sp, #16]
	fsub	s0, s0, s1
	str	s0, [sp, #12]
// BB#4:                                // %do.cond
                                        //   in Loop: Header=BB0_3 Depth=1
	orr	w8, wzr, #0x1
	adrp	x9, .LCPI0_0
	ldr	d0, [x9, :lo12:.LCPI0_0]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	str	w8, [sp, #8]            // 4-byte Folded Spill
	b.gt	.LBB0_6
// BB#5:                                // %lor.rhs
                                        //   in Loop: Header=BB0_3 Depth=1
	adrp	x8, .LCPI0_1
	ldr	d0, [x8, :lo12:.LCPI0_1]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	cset	 w9, mi
	str	w9, [sp, #8]            // 4-byte Folded Spill
.LBB0_6:                                // %lor.end
                                        //   in Loop: Header=BB0_3 Depth=1
	ldr	w0, [sp, #8]            // 4-byte Folded Reload
	cmp	 w0, #0                 // =0
	b.ne	.LBB0_3
// BB#7:                                // %do.end
	ldr	s0, [sp, #20]
	str	s0, [sp, #28]
.LBB0_8:                                // %return
	ldr	s0, [sp, #28]
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	sqroot, .Ltmp1-sqroot

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI1_0:
	.word	1078529622              // float 3.1415
	.text
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	adrp	x8, .LCPI1_0
	ldr	s0, [x8, :lo12:.LCPI1_0]
	movz	w9, #0
	stur	w9, [x29, #-4]
	bl	sqroot
	bl	sqroot
	bl	sqroot
	movz	w0, #0
	str	s0, [sp, #8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	main, .Ltmp2-main


	.ident	"clang version 3.5.0 "
