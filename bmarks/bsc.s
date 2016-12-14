	.text
	.file	"bsc.c"
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI0_0:
	.word	1071442339              // float 1.72588003
.LCPI0_1:
	.word	1052001529              // float 0.35208872
.LCPI0_2:
	.word	1069530997              // float 1.4980303
.LCPI0_3:
	.word	1123578743              // float 124.225517
.LCPI0_4:
	.word	872415232               // float 1.1920929E-7
	.text
	.globl	fastlog2
	.align	2
	.type	fastlog2,@function
fastlog2:                               // @fastlog2
// BB#0:                                // %entry
	sub	sp, sp, #32             // =32
	adrp	x8, .LCPI0_0
	ldr	s1, [x8, :lo12:.LCPI0_0]
	adrp	x8, .LCPI0_1
	ldr	s2, [x8, :lo12:.LCPI0_1]
	adrp	x8, .LCPI0_2
	ldr	s3, [x8, :lo12:.LCPI0_2]
	adrp	x8, .LCPI0_3
	ldr	s4, [x8, :lo12:.LCPI0_3]
	adrp	x8, .LCPI0_4
	ldr	s5, [x8, :lo12:.LCPI0_4]
	str	s0, [sp, #28]
	ldr	s0, [sp, #28]
	str	s0, [sp, #24]
	ldr	w9, [sp, #24]
	orr	w10, wzr, #0x7fffff
	and	 w9, w9, w10
	orr	w10, wzr, #0x3f000000
	orr	 w9, w9, w10
	str	w9, [sp, #16]
	ldr	w9, [sp, #24]
	ucvtf	s0, w9
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	fmul	s0, s0, s5
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	fsub	s0, s0, s4
	ldr	s4, [sp, #16]
	fmul	s3, s3, s4
	fsub	s0, s0, s3
	ldr	s3, [sp, #16]
	fadd	s2, s2, s3
	fdiv	s1, s1, s2
	fsub	s0, s0, s1
	add	sp, sp, #32             // =32
	ret
.Ltmp1:
	.size	fastlog2, .Ltmp1-fastlog2

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI1_0:
	.word	1060205080              // float 0.693147182
	.text
	.globl	fastlog
	.align	2
	.type	fastlog,@function
fastlog:                                // @fastlog
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	stur	s0, [x29, #-4]
	ldur	s0, [x29, #-4]
	bl	fastlog2
	adrp	x8, .LCPI1_0
	ldr	s1, [x8, :lo12:.LCPI1_0]
	fmul	s0, s1, s0
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp2:
	.size	fastlog, .Ltmp2-fastlog

	.globl	ipow
	.align	2
	.type	ipow,@function
ipow:                                   // @ipow
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	movz	w8, #0
	orr	w9, wzr, #0x1
	str	w0, [sp, #12]
	str	w1, [sp, #8]
	str	 w9, [sp]
	str	w8, [sp, #4]
.LBB2_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #4]
	ldr	w9, [sp, #8]
	cmp	 w8, w9
	b.lt	.LBB2_2
	b	.LBB2_4
.LBB2_2:                                // %for.body
                                        //   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #12]
	ldr	 w9, [sp]
	mul	 w8, w9, w8
	str	 w8, [sp]
// BB#3:                                // %for.inc
                                        //   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #4]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #4]
	b	.LBB2_1
.LBB2_4:                                // %for.end
	ldr	 w8, [sp]
	mov	 w9, w8
	sxtw	x0, w9
	add	sp, sp, #16             // =16
	ret
.Ltmp4:
	.size	ipow, .Ltmp4-ipow

	.globl	fpow
	.align	2
	.type	fpow,@function
fpow:                                   // @fpow
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	movz	x8, #0
	scvtf	s2, x8
	orr	x8, xzr, #0x1
	scvtf	s3, x8
	str	s0, [sp, #12]
	str	s1, [sp, #8]
	str	 s3, [sp]
	str	s2, [sp, #4]
.LBB3_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	s0, [sp, #4]
	ldr	s1, [sp, #8]
	fcmp	s0, s1
	b.mi	.LBB3_2
	b	.LBB3_4
.LBB3_2:                                // %for.body
                                        //   in Loop: Header=BB3_1 Depth=1
	ldr	s0, [sp, #12]
	ldr	 s1, [sp]
	fmul	s0, s1, s0
	str	 s0, [sp]
// BB#3:                                // %for.inc
                                        //   in Loop: Header=BB3_1 Depth=1
	orr	x8, xzr, #0x1
	scvtf	s0, x8
	ldr	s1, [sp, #4]
	fadd	s0, s1, s0
	str	s0, [sp, #4]
	b	.LBB3_1
.LBB3_4:                                // %for.end
	ldr	 s0, [sp]
	add	sp, sp, #16             // =16
	ret
.Ltmp6:
	.size	fpow, .Ltmp6-fpow

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI4_0:
	.xword	4554050699414489        // double 2.25E-308
.LCPI4_1:
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
	b.ls	.LBB4_1
	b	.LBB4_2
.LBB4_1:                                // %if.then
	movz	x8, #0
	scvtf	s0, x8
	str	s0, [sp, #28]
	b	.LBB4_8
.LBB4_2:                                // %if.end
	b	.LBB4_3
.LBB4_3:                                // %do.body
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
                                        //   in Loop: Header=BB4_3 Depth=1
	orr	w8, wzr, #0x1
	adrp	x9, .LCPI4_0
	ldr	d0, [x9, :lo12:.LCPI4_0]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	str	w8, [sp, #8]            // 4-byte Folded Spill
	b.gt	.LBB4_6
// BB#5:                                // %lor.rhs
                                        //   in Loop: Header=BB4_3 Depth=1
	adrp	x8, .LCPI4_1
	ldr	d0, [x8, :lo12:.LCPI4_1]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	cset	 w9, mi
	str	w9, [sp, #8]            // 4-byte Folded Spill
.LBB4_6:                                // %lor.end
                                        //   in Loop: Header=BB4_3 Depth=1
	ldr	w0, [sp, #8]            // 4-byte Folded Reload
	cmp	 w0, #0                 // =0
	b.ne	.LBB4_3
// BB#7:                                // %do.end
	ldr	s0, [sp, #20]
	str	s0, [sp, #28]
.LBB4_8:                                // %return
	ldr	s0, [sp, #28]
	add	sp, sp, #32             // =32
	ret
.Ltmp8:
	.size	sqroot, .Ltmp8-sqroot

	.globl	fabsolute
	.align	2
	.type	fabsolute,@function
fabsolute:                              // @fabsolute
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	fcmp	s0, #0.0
	b.gt	.LBB5_1
	b	.LBB5_2
.LBB5_1:                                // %cond.true
	ldr	s0, [sp, #12]
	str	s0, [sp, #8]            // 4-byte Folded Spill
	b	.LBB5_3
.LBB5_2:                                // %cond.false
	ldr	s0, [sp, #12]
	fneg	s0, s0
	str	s0, [sp, #8]            // 4-byte Folded Spill
.LBB5_3:                                // %cond.end
	ldr	s0, [sp, #8]            // 4-byte Folded Reload
	add	sp, sp, #16             // =16
	ret
.Ltmp10:
	.size	fabsolute, .Ltmp10-fabsolute

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI6_0:
	.word	1086918619              // float 6.28318548
.LCPI6_1:
	.word	1076754516              // float 2.71828175
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI6_2:
	.xword	4604029899060858061     // double 0.65000000000000002
	.text
	.globl	normalDistribution
	.align	2
	.type	normalDistribution,@function
normalDistribution:                     // @normalDistribution
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #80             // =80
	adrp	x8, .LCPI6_0
	ldr	s1, [x8, :lo12:.LCPI6_0]
	stur	d0, [x29, #-8]
	mov		v0.16b, v1.16b
	bl	sqroot
	orr	x8, xzr, #0x2
	scvtf	s1, x8
	fcvt	d2, s0
	stur	d2, [x29, #-16]
	mov		v0.16b, v1.16b
	bl	sqroot
	movz	x8, #0xa
	scvtf	d2, x8
	fcvt	d3, s0
	fdiv	d2, d2, d3
	stur	d2, [x29, #-24]
	ldur	d2, [x29, #-8]
	fcvt	s0, d2
	bl	fabsolute
	movz	x8, #0x25
	scvtf	d2, x8
	movz	x8, #0
	scvtf	d3, x8
	fcvt	d4, s0
	stur	d4, [x29, #-32]
	str	d3, [sp, #40]
	ldur	d3, [x29, #-32]
	fcmp	d3, d2
	b.ls	.LBB6_1
	b	.LBB6_5
.LBB6_1:                                // %if.then
	adrp	x8, .LCPI6_1
	ldr	s0, [x8, :lo12:.LCPI6_1]
	orr	x8, xzr, #0x2
	scvtf	d1, x8
	ldur	d2, [x29, #-32]
	fneg	d2, d2
	ldur	d3, [x29, #-32]
	fmul	d2, d2, d3
	fdiv	d1, d2, d1
	fcvt	s1, d1
	bl	fpow
	fcvt	d2, s0
	ldur	d3, [x29, #-16]
	fdiv	d2, d2, d3
	str	d2, [sp, #32]
	ldur	d2, [x29, #-32]
	ldur	d3, [x29, #-24]
	fcmp	d2, d3
	b.mi	.LBB6_2
	b	.LBB6_3
.LBB6_2:                                // %if.then14
	adrp	x8, normalDistribution.b
	add	x8, x8, :lo12:normalDistribution.b
	adrp	x9, normalDistribution.a
	add	x9, x9, :lo12:normalDistribution.a
	ldr	d0, [x9, #48]
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x9, #40]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x9, #32]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x9, #24]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x9, #16]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x9, #8]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	 d1, [x9]
	fadd	d0, d0, d1
	str	d0, [sp, #24]
	ldr	d0, [x8, #56]
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #48]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #40]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #32]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #24]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #16]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	d1, [x8, #8]
	fadd	d0, d0, d1
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldr	 d1, [x8]
	fadd	d0, d0, d1
	str	d0, [sp, #16]
	ldur	d0, [x29, #-16]
	ldr	d1, [sp, #32]
	fmul	d0, d0, d1
	ldr	d1, [sp, #24]
	fmul	d0, d0, d1
	ldr	d1, [sp, #16]
	fdiv	d0, d0, d1
	str	d0, [sp, #40]
	b	.LBB6_4
.LBB6_3:                                // %if.else
	orr	x8, xzr, #0x1
	scvtf	d0, x8
	orr	x8, xzr, #0x2
	scvtf	d1, x8
	orr	x8, xzr, #0x3
	scvtf	d2, x8
	orr	x8, xzr, #0x4
	scvtf	d3, x8
	adrp	x8, .LCPI6_2
	ldr	d4, [x8, :lo12:.LCPI6_2]
	ldur	d5, [x29, #-32]
	ldur	d6, [x29, #-32]
	ldur	d7, [x29, #-32]
	ldur	d16, [x29, #-32]
	ldur	d17, [x29, #-32]
	fadd	d4, d17, d4
	fdiv	d3, d3, d4
	fadd	d3, d16, d3
	fdiv	d2, d2, d3
	fadd	d2, d7, d2
	fdiv	d1, d1, d2
	fadd	d1, d6, d1
	fdiv	d0, d0, d1
	fadd	d0, d5, d0
	str	d0, [sp, #8]
	ldr	d0, [sp, #32]
	ldr	d1, [sp, #8]
	fdiv	d0, d0, d1
	str	d0, [sp, #40]
.LBB6_4:                                // %if.end
	b	.LBB6_5
.LBB6_5:                                // %if.end53
	ldur	d0, [x29, #-8]
	fcmp	d0, #0.0
	b.ge	.LBB6_6
	b	.LBB6_7
.LBB6_6:                                // %cond.true
	orr	x8, xzr, #0x1
	scvtf	d0, x8
	ldr	d1, [sp, #40]
	fsub	d0, d0, d1
	str	 d0, [sp]               // 8-byte Folded Spill
	b	.LBB6_8
.LBB6_7:                                // %cond.false
	ldr	d0, [sp, #40]
	str	 d0, [sp]               // 8-byte Folded Spill
.LBB6_8:                                // %cond.end
	ldr	 d0, [sp]               // 8-byte Folded Reload
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp11:
	.size	normalDistribution, .Ltmp11-normalDistribution

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI7_0:
	.xword	4397347889687374747     // double 9.9999999999999999E-15
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI7_1:
	.word	1076754516              // float 2.71828175
	.text
	.globl	callOptionPrice
	.align	2
	.type	callOptionPrice,@function
callOptionPrice:                        // @callOptionPrice
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #160            // =160
	adrp	x8, .LCPI7_0
	ldr	d6, [x8, :lo12:.LCPI7_0]
	stur	d0, [x29, #-16]
	stur	d1, [x29, #-24]
	stur	d2, [x29, #-32]
	stur	d3, [x29, #-40]
	stur	d4, [x29, #-48]
	stur	d5, [x29, #-56]
	ldur	d0, [x29, #-16]
	fcmp	d0, d6
	b.mi	.LBB7_1
	b	.LBB7_2
.LBB7_1:                                // %if.then
	movz	x8, #0
	scvtf	d0, x8
	stur	d0, [x29, #-8]
	b	.LBB7_11
.LBB7_2:                                // %if.end
	adrp	x8, .LCPI7_0
	ldr	d0, [x8, :lo12:.LCPI7_0]
	ldur	d1, [x29, #-48]
	fcmp	d1, d0
	b.mi	.LBB7_3
	b	.LBB7_6
.LBB7_3:                                // %if.then2
	adrp	x8, .LCPI7_1
	ldr	s0, [x8, :lo12:.LCPI7_1]
	ldur	d1, [x29, #-16]
	ldur	d2, [x29, #-32]
	ldur	d3, [x29, #-40]
	fneg	d3, d3
	ldur	d4, [x29, #-56]
	ldur	d5, [x29, #-24]
	fsub	d4, d4, d5
	fmul	d3, d3, d4
	fcvt	s6, d3
	str	d1, [sp, #80]           // 8-byte Folded Spill
	mov		v1.16b, v6.16b
	str	d2, [sp, #72]           // 8-byte Folded Spill
	bl	fpow
	fcvt	d2, s0
	ldr	d3, [sp, #72]           // 8-byte Folded Reload
	fmul	d2, d3, d2
	ldr	d3, [sp, #80]           // 8-byte Folded Reload
	fcmp	d3, d2
	b.mi	.LBB7_4
	b	.LBB7_5
.LBB7_4:                                // %if.then8
	movz	x8, #0
	scvtf	d0, x8
	stur	d0, [x29, #-8]
	b	.LBB7_11
.LBB7_5:                                // %if.else
	adrp	x8, .LCPI7_1
	ldr	s0, [x8, :lo12:.LCPI7_1]
	ldur	d1, [x29, #-16]
	ldur	d2, [x29, #-32]
	ldur	d3, [x29, #-40]
	fneg	d3, d3
	ldur	d4, [x29, #-56]
	ldur	d5, [x29, #-24]
	fsub	d4, d4, d5
	fmul	d3, d3, d4
	fcvt	s6, d3
	str	d1, [sp, #64]           // 8-byte Folded Spill
	mov		v1.16b, v6.16b
	str	d2, [sp, #56]           // 8-byte Folded Spill
	bl	fpow
	fcvt	d2, s0
	ldr	d3, [sp, #56]           // 8-byte Folded Reload
	fmul	d2, d3, d2
	ldr	d3, [sp, #64]           // 8-byte Folded Reload
	fsub	d2, d3, d2
	stur	d2, [x29, #-8]
	b	.LBB7_11
.LBB7_6:                                // %if.end17
	ldur	d0, [x29, #-56]
	ldur	d1, [x29, #-24]
	fsub	d0, d0, d1
	fcvt	s0, d0
	bl	fabsolute
	adrp	x8, .LCPI7_0
	ldr	d1, [x8, :lo12:.LCPI7_0]
	fcvt	d2, s0
	fcmp	d2, d1
	b.mi	.LBB7_7
	b	.LBB7_10
.LBB7_7:                                // %if.then24
	ldur	d0, [x29, #-16]
	ldur	d1, [x29, #-32]
	fcmp	d0, d1
	b.mi	.LBB7_8
	b	.LBB7_9
.LBB7_8:                                // %if.then27
	movz	x8, #0
	scvtf	d0, x8
	stur	d0, [x29, #-8]
	b	.LBB7_11
.LBB7_9:                                // %if.else28
	ldur	d0, [x29, #-16]
	ldur	d1, [x29, #-32]
	fsub	d0, d0, d1
	stur	d0, [x29, #-8]
	b	.LBB7_11
.LBB7_10:                               // %if.end30
	ldur	d0, [x29, #-16]
	ldur	d1, [x29, #-32]
	fdiv	d0, d0, d1
	fcvt	s0, d0
	bl	fastlog
	orr	x8, xzr, #0x2
	scvtf	d1, x8
	fcvt	d2, s0
	ldur	d3, [x29, #-40]
	ldur	d4, [x29, #-48]
	ldur	d5, [x29, #-48]
	fmul	d4, d4, d5
	fdiv	d1, d4, d1
	fadd	d1, d3, d1
	ldur	d3, [x29, #-56]
	ldur	d4, [x29, #-24]
	fsub	d3, d3, d4
	fmul	d1, d1, d3
	fadd	d1, d2, d1
	ldur	d2, [x29, #-48]
	ldur	d3, [x29, #-56]
	ldur	d4, [x29, #-24]
	fsub	d3, d3, d4
	fcvt	s0, d3
	str	d1, [sp, #48]           // 8-byte Folded Spill
	str	d2, [sp, #40]           // 8-byte Folded Spill
	bl	sqroot
	fcvt	d1, s0
	ldr	d2, [sp, #40]           // 8-byte Folded Reload
	fmul	d1, d2, d1
	ldr	d2, [sp, #48]           // 8-byte Folded Reload
	fdiv	d1, d2, d1
	stur	d1, [x29, #-64]
	ldur	d1, [x29, #-16]
	ldur	d2, [x29, #-32]
	fdiv	d1, d1, d2
	fcvt	s0, d1
	bl	fastlog
	orr	x8, xzr, #0x2
	scvtf	d1, x8
	fcvt	d2, s0
	ldur	d3, [x29, #-40]
	ldur	d4, [x29, #-48]
	ldur	d5, [x29, #-48]
	fmul	d4, d4, d5
	fdiv	d1, d4, d1
	fsub	d1, d3, d1
	ldur	d3, [x29, #-56]
	ldur	d4, [x29, #-24]
	fsub	d3, d3, d4
	fmul	d1, d1, d3
	fadd	d1, d2, d1
	ldur	d2, [x29, #-48]
	ldur	d3, [x29, #-56]
	ldur	d4, [x29, #-24]
	fsub	d3, d3, d4
	fcvt	s0, d3
	str	d1, [sp, #32]           // 8-byte Folded Spill
	str	d2, [sp, #24]           // 8-byte Folded Spill
	bl	sqroot
	fcvt	d1, s0
	ldr	d2, [sp, #24]           // 8-byte Folded Reload
	fmul	d1, d2, d1
	ldr	d2, [sp, #32]           // 8-byte Folded Reload
	fdiv	d1, d2, d1
	stur	d1, [x29, #-72]
	ldur	d0, [x29, #-64]
	bl	normalDistribution
	ldur	d1, [x29, #-16]
	fmul	d0, d0, d1
	ldur	d1, [x29, #-72]
	str	d0, [sp, #16]           // 8-byte Folded Spill
	mov		v0.16b, v1.16b
	bl	normalDistribution
	adrp	x8, .LCPI7_1
	ldr	s6, [x8, :lo12:.LCPI7_1]
	ldur	d1, [x29, #-32]
	fmul	d0, d0, d1
	ldur	d1, [x29, #-40]
	fneg	d1, d1
	ldur	d2, [x29, #-56]
	ldur	d3, [x29, #-24]
	fsub	d2, d2, d3
	fmul	d1, d1, d2
	fcvt	s1, d1
	str	d0, [sp, #8]            // 8-byte Folded Spill
	mov		v0.16b, v6.16b
	bl	fpow
	fcvt	d2, s0
	ldr	d3, [sp, #8]            // 8-byte Folded Reload
	fmul	d2, d3, d2
	ldr	d3, [sp, #16]           // 8-byte Folded Reload
	fsub	d2, d3, d2
	stur	d2, [x29, #-8]
.LBB7_11:                               // %return
	ldur	d0, [x29, #-8]
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp12:
	.size	callOptionPrice, .Ltmp12-callOptionPrice

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI8_0:
	.xword	4587366580439587226     // double 0.050000000000000003
.LCPI8_1:
	.xword	4596373779694328218     // double 0.20000000000000001
	.text
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #192            // =192
	movz	w8, #0
	stur	w8, [x29, #-4]
	str	w8, [sp, #20]
.LBB8_1:                                // %for.cond
                                        // =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #20]
	cmp	 w8, #20                // =20
	b.lt	.LBB8_2
	b	.LBB8_4
.LBB8_2:                                // %for.body
                                        //   in Loop: Header=BB8_1 Depth=1
	movz	x8, #0
	scvtf	d1, x8
	orr	x8, xzr, #0x1
	scvtf	d0, x8
	adrp	x8, .LCPI8_0
	ldr	d3, [x8, :lo12:.LCPI8_0]
	adrp	x8, .LCPI8_1
	ldr	d4, [x8, :lo12:.LCPI8_1]
	movz	w9, #0xa
	ldr	w10, [sp, #20]
	mul	 w9, w9, w10
	scvtf	d2, w9
	str	 d0, [sp]               // 8-byte Folded Spill
	mov		v0.16b, v2.16b
	ldr	 d2, [sp]               // 8-byte Folded Reload
	ldr	 d5, [sp]               // 8-byte Folded Reload
	bl	callOptionPrice
	add	x8, sp, #24             // =24
	ldr	w9, [sp, #20]
	mov	 w11, w9
	sxtw	x11, w11
	orr	x12, xzr, #0x3
	lsl	x11, x11, x12
	add	 x8, x8, x11
	str	 d0, [x8]
// BB#3:                                // %for.inc
                                        //   in Loop: Header=BB8_1 Depth=1
	ldr	w8, [sp, #20]
	orr	w9, wzr, #0x1
	add	 w8, w8, w9
	str	w8, [sp, #20]
	b	.LBB8_1
.LBB8_4:                                // %for.end
	ldr	d0, [sp, #176]
	str	d0, [sp, #8]
	ldr	d0, [sp, #8]
	fcvtzs	w0, d0
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp13:
	.size	main, .Ltmp13-main

	.type	normalDistribution.a,@object // @normalDistribution.a
	.section	.rodata,"a",@progbits
	.align	3
normalDistribution.a:
	.xword	4641951856941385701     // double 2.202069e+02
	.xword	4641987278042991858     // double 2.212136e+02
	.xword	4637587295927897404     // double 1.120793e+02
	.xword	4629969628904301617     // double 3.391287e+01
	.xword	4618862461878562595     // double 6.373962e+00
	.xword	4604483709361366815     // double 7.003831e-01
	.xword	4585242682365311966     // double 3.526250e-02
	.size	normalDistribution.a, 56

	.type	normalDistribution.b,@object // @normalDistribution.b
	.align	3
normalDistribution.b:
	.xword	4646455456568756197     // double 4.404137e+02
	.xword	4650193787666601802     // double 7.938265e+02
	.xword	4648817261744363383     // double 6.373336e+02
	.xword	4643924829630265376     // double 2.965642e+02
	.xword	4635807068080809370     // double 8.678073e+01
	.xword	4625214881692112029     // double 1.606418e+01
	.xword	4610585641154542865     // double 1.755667e+00
	.xword	4591033472335690698     // double 8.838835e-02
	.size	normalDistribution.b, 64


	.ident	"clang version 3.5.0 "
