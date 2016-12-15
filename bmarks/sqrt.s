	.text
	.file	"sqrt.c"
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

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI6_0:
	.xword	-4609115380310813455    // double -3.1415926500000002
.LCPI6_1:
	.xword	4614256656543962353     // double 3.1415926500000002
.LCPI6_2:
	.xword	4618760256182591848     // double 6.2831853100000004
.LCPI6_3:
	.xword	4600972580644005721     // double 0.40528473500000001
.LCPI6_4:
	.xword	4608412980290544294     // double 1.2732395400000001
.LCPI6_5:
	.xword	4597274499619802317     // double 0.22500000000000001
	.text
	.globl	fsine
	.align	2
	.type	fsine,@function
fsine:                                  // @fsine
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	adrp	x8, .LCPI6_0
	ldr	d1, [x8, :lo12:.LCPI6_0]
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	fcvt	d2, s0
	fcmp	d2, d1
	b.mi	.LBB6_1
	b	.LBB6_2
.LBB6_1:                                // %if.then
	adrp	x8, .LCPI6_2
	ldr	d0, [x8, :lo12:.LCPI6_2]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fadd	d0, d2, d0
	fcvt	s1, d0
	str	s1, [sp, #12]
	b	.LBB6_5
.LBB6_2:                                // %if.else
	adrp	x8, .LCPI6_1
	ldr	d0, [x8, :lo12:.LCPI6_1]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	b.gt	.LBB6_3
	b	.LBB6_4
.LBB6_3:                                // %if.then7
	adrp	x8, .LCPI6_2
	ldr	d0, [x8, :lo12:.LCPI6_2]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fsub	d0, d2, d0
	fcvt	s1, d0
	str	s1, [sp, #12]
.LBB6_4:                                // %if.end
	b	.LBB6_5
.LBB6_5:                                // %if.end10
	ldr	s0, [sp, #12]
	fcmp	s0, #0.0
	b.mi	.LBB6_6
	b	.LBB6_10
.LBB6_6:                                // %if.then13
	adrp	x8, .LCPI6_3
	ldr	d0, [x8, :lo12:.LCPI6_3]
	adrp	x8, .LCPI6_4
	ldr	d1, [x8, :lo12:.LCPI6_4]
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d1, d1, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	fadd	d0, d1, d0
	fcvt	s2, d0
	str	s2, [sp, #8]
	ldr	s2, [sp, #8]
	fcmp	s2, #0.0
	b.mi	.LBB6_7
	b	.LBB6_8
.LBB6_7:                                // %if.then23
	adrp	x8, .LCPI6_5
	ldr	d0, [x8, :lo12:.LCPI6_5]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fneg	s2, s2
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
	b	.LBB6_9
.LBB6_8:                                // %if.else32
	adrp	x8, .LCPI6_5
	ldr	d0, [x8, :lo12:.LCPI6_5]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
.LBB6_9:                                // %if.end40
	b	.LBB6_14
.LBB6_10:                               // %if.else41
	adrp	x8, .LCPI6_3
	ldr	d0, [x8, :lo12:.LCPI6_3]
	adrp	x8, .LCPI6_4
	ldr	d1, [x8, :lo12:.LCPI6_4]
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d1, d1, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	fsub	d0, d1, d0
	fcvt	s2, d0
	str	s2, [sp, #8]
	ldr	s2, [sp, #8]
	fcmp	s2, #0.0
	b.mi	.LBB6_11
	b	.LBB6_12
.LBB6_11:                               // %if.then52
	adrp	x8, .LCPI6_5
	ldr	d0, [x8, :lo12:.LCPI6_5]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fneg	s2, s2
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
	b	.LBB6_13
.LBB6_12:                               // %if.else61
	adrp	x8, .LCPI6_5
	ldr	d0, [x8, :lo12:.LCPI6_5]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
.LBB6_13:                               // %if.end69
	b	.LBB6_14
.LBB6_14:                               // %if.end70
	ldr	s0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp12:
	.size	fsine, .Ltmp12-fsine

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI7_0:
	.xword	-4609115380310813455    // double -3.1415926500000002
.LCPI7_1:
	.xword	4614256656543962353     // double 3.1415926500000002
.LCPI7_2:
	.xword	4618760256182591848     // double 6.2831853100000004
.LCPI7_3:
	.xword	4609753056894073858     // double 1.5707963199999999
.LCPI7_4:
	.xword	4600972580644005721     // double 0.40528473500000001
.LCPI7_5:
	.xword	4608412980290544294     // double 1.2732395400000001
.LCPI7_6:
	.xword	4597274499619802317     // double 0.22500000000000001
	.text
	.globl	fcosine
	.align	2
	.type	fcosine,@function
fcosine:                                // @fcosine
// BB#0:                                // %entry
	sub	sp, sp, #16             // =16
	adrp	x8, .LCPI7_0
	ldr	d1, [x8, :lo12:.LCPI7_0]
	str	s0, [sp, #12]
	ldr	s0, [sp, #12]
	fcvt	d2, s0
	fcmp	d2, d1
	b.mi	.LBB7_1
	b	.LBB7_2
.LBB7_1:                                // %if.then
	adrp	x8, .LCPI7_2
	ldr	d0, [x8, :lo12:.LCPI7_2]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fadd	d0, d2, d0
	fcvt	s1, d0
	str	s1, [sp, #12]
	b	.LBB7_5
.LBB7_2:                                // %if.else
	adrp	x8, .LCPI7_1
	ldr	d0, [x8, :lo12:.LCPI7_1]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fcmp	d2, d0
	b.gt	.LBB7_3
	b	.LBB7_4
.LBB7_3:                                // %if.then7
	adrp	x8, .LCPI7_2
	ldr	d0, [x8, :lo12:.LCPI7_2]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fsub	d0, d2, d0
	fcvt	s1, d0
	str	s1, [sp, #12]
.LBB7_4:                                // %if.end
	b	.LBB7_5
.LBB7_5:                                // %if.end10
	adrp	x8, .LCPI7_1
	ldr	d0, [x8, :lo12:.LCPI7_1]
	adrp	x8, .LCPI7_3
	ldr	d1, [x8, :lo12:.LCPI7_3]
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fadd	d1, d3, d1
	fcvt	s2, d1
	str	s2, [sp, #12]
	ldr	s2, [sp, #12]
	fcvt	d1, s2
	fcmp	d1, d0
	b.gt	.LBB7_6
	b	.LBB7_7
.LBB7_6:                                // %if.then17
	adrp	x8, .LCPI7_2
	ldr	d0, [x8, :lo12:.LCPI7_2]
	ldr	s1, [sp, #12]
	fcvt	d2, s1
	fsub	d0, d2, d0
	fcvt	s1, d0
	str	s1, [sp, #12]
.LBB7_7:                                // %if.end21
	ldr	s0, [sp, #12]
	fcmp	s0, #0.0
	b.mi	.LBB7_8
	b	.LBB7_12
.LBB7_8:                                // %if.then24
	adrp	x8, .LCPI7_4
	ldr	d0, [x8, :lo12:.LCPI7_4]
	adrp	x8, .LCPI7_5
	ldr	d1, [x8, :lo12:.LCPI7_5]
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d1, d1, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	fadd	d0, d1, d0
	fcvt	s2, d0
	str	s2, [sp, #8]
	ldr	s2, [sp, #8]
	fcmp	s2, #0.0
	b.mi	.LBB7_9
	b	.LBB7_10
.LBB7_9:                                // %if.then34
	adrp	x8, .LCPI7_6
	ldr	d0, [x8, :lo12:.LCPI7_6]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fneg	s2, s2
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
	b	.LBB7_11
.LBB7_10:                               // %if.else43
	adrp	x8, .LCPI7_6
	ldr	d0, [x8, :lo12:.LCPI7_6]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
.LBB7_11:                               // %if.end51
	b	.LBB7_16
.LBB7_12:                               // %if.else52
	adrp	x8, .LCPI7_4
	ldr	d0, [x8, :lo12:.LCPI7_4]
	adrp	x8, .LCPI7_5
	ldr	d1, [x8, :lo12:.LCPI7_5]
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d1, d1, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	ldr	s2, [sp, #12]
	fcvt	d3, s2
	fmul	d0, d0, d3
	fsub	d0, d1, d0
	fcvt	s2, d0
	str	s2, [sp, #8]
	ldr	s2, [sp, #8]
	fcmp	s2, #0.0
	b.mi	.LBB7_13
	b	.LBB7_14
.LBB7_13:                               // %if.then63
	adrp	x8, .LCPI7_6
	ldr	d0, [x8, :lo12:.LCPI7_6]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fneg	s2, s2
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
	b	.LBB7_15
.LBB7_14:                               // %if.else72
	adrp	x8, .LCPI7_6
	ldr	d0, [x8, :lo12:.LCPI7_6]
	ldr	s1, [sp, #8]
	ldr	s2, [sp, #8]
	fmul	s1, s1, s2
	ldr	s2, [sp, #8]
	fsub	s1, s1, s2
	fcvt	d3, s1
	fmul	d0, d0, d3
	ldr	s1, [sp, #8]
	fcvt	d3, s1
	fadd	d0, d0, d3
	fcvt	s1, d0
	str	s1, [sp, #8]
.LBB7_15:                               // %if.end80
	b	.LBB7_16
.LBB7_16:                               // %if.end81
	ldr	s0, [sp, #8]
	add	sp, sp, #16             // =16
	ret
.Ltmp14:
	.size	fcosine, .Ltmp14-fcosine

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	sub	sp, sp, #16             // =16
	movz	x8, #0x307, lsl #32
	movk	x8, #0xdf04, lsl #16
	scvtf	s0, x8
	movz	w9, #0
	stur	w9, [x29, #-4]
	bl	sqroot
	bl	sqroot
	bl	sqroot
	str	s0, [sp, #8]
	ldr	s0, [sp, #8]
	fcvtzs	w0, s0
	mov	 sp, x29
	ldp	x29, x30, [sp], #16
	ret
.Ltmp15:
	.size	main, .Ltmp15-main


	.ident	"clang version 3.5.0 "
