	.text
	.file	"sqrt.c"
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI0_0:
	.word	3271062391              // float -124.225517
.LCPI0_1:
	.word	872415232               // float 1.1920929E-7
.LCPI0_2:
	.word	3217014645              // float -1.4980303
.LCPI0_3:
	.word	1052001529              // float 0.35208872
.LCPI0_4:
	.word	3218925987              // float -1.72588003
	.text
	.globl	fastlog2
	.align	2
	.type	fastlog2,@function
fastlog2:                               // @fastlog2
// BB#0:                                // %entry
	fmov	w8, s0
	orr	w9, wzr, #0x3f000000
	bfxil	w9, w8, #0, #23
	ucvtf	s0, w8
	adrp	x8, .LCPI0_0
	ldr	s1, [x8, :lo12:.LCPI0_0]
	adrp	x8, .LCPI0_1
	ldr	s2, [x8, :lo12:.LCPI0_1]
	fmadd	s0, s0, s2, s1
	fmov	s1, w9
	adrp	x8, .LCPI0_2
	ldr	s2, [x8, :lo12:.LCPI0_2]
	fmadd	s0, s1, s2, s0
	adrp	x8, .LCPI0_3
	ldr	s2, [x8, :lo12:.LCPI0_3]
	fadd	s1, s1, s2
	adrp	x8, .LCPI0_4
	ldr	s2, [x8, :lo12:.LCPI0_4]
	fdiv	s1, s2, s1
	fadd	s0, s0, s1
	ret
.Ltmp1:
	.size	fastlog2, .Ltmp1-fastlog2

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI1_0:
	.word	3271062391              // float -124.225517
.LCPI1_1:
	.word	872415232               // float 1.1920929E-7
.LCPI1_2:
	.word	3217014645              // float -1.4980303
.LCPI1_3:
	.word	1052001529              // float 0.35208872
.LCPI1_4:
	.word	3218925987              // float -1.72588003
.LCPI1_5:
	.word	1060205080              // float 0.693147182
	.text
	.globl	fastlog
	.align	2
	.type	fastlog,@function
fastlog:                                // @fastlog
// BB#0:                                // %entry
	fmov	w8, s0
	orr	w9, wzr, #0x3f000000
	bfxil	w9, w8, #0, #23
	ucvtf	s0, w8
	adrp	x8, .LCPI1_0
	ldr	s1, [x8, :lo12:.LCPI1_0]
	adrp	x8, .LCPI1_1
	ldr	s2, [x8, :lo12:.LCPI1_1]
	fmadd	s0, s0, s2, s1
	fmov	s1, w9
	adrp	x8, .LCPI1_2
	ldr	s2, [x8, :lo12:.LCPI1_2]
	fmadd	s0, s1, s2, s0
	adrp	x8, .LCPI1_3
	ldr	s2, [x8, :lo12:.LCPI1_3]
	fadd	s1, s1, s2
	adrp	x8, .LCPI1_4
	ldr	s2, [x8, :lo12:.LCPI1_4]
	fdiv	s1, s2, s1
	fadd	s0, s0, s1
	adrp	x8, .LCPI1_5
	ldr	s1, [x8, :lo12:.LCPI1_5]
	fmul	s0, s0, s1
	ret
.Ltmp3:
	.size	fastlog, .Ltmp3-fastlog

	.globl	ipow
	.align	2
	.type	ipow,@function
ipow:                                   // @ipow
// BB#0:                                // %entry
	orr	w8, wzr, #0x1
	cmp	 w1, #1                 // =1
	b.lt	.LBB2_11
// BB#1:                                // %for.body.preheader
	cbz	w1, .LBB2_5
// BB#2:                                // %overflow.checked
	and	w8, w1, #0xfffffff8
	cbz	w8, .LBB2_6
// BB#3:                                // %vector.ph
	dup	v2.4s, w0
	movi	v0.4s, #0x1
	mov	 w9, w8
	mov		v1.16b, v0.16b
.LBB2_4:                                // %vector.body
                                        // =>This Inner Loop Header: Depth=1
	mul	v0.4s, v0.4s, v2.4s
	mul	v1.4s, v1.4s, v2.4s
	sub	w9, w9, #8              // =8
	cbnz	w9, .LBB2_4
	b	.LBB2_7
.LBB2_5:
	mov	 w8, wzr
	orr	w9, wzr, #0x1
	b	.LBB2_8
.LBB2_6:
	mov	 w8, wzr
	movi	v0.4s, #0x1
	mov		v1.16b, v0.16b
.LBB2_7:                                // %middle.block
	mul	v0.4s, v1.4s, v0.4s
	ext	v1.16b, v0.16b, v0.16b, #8
	mul	v0.4s, v0.4s, v1.4s
	mul	v0.4s, v0.4s, v0.s[1]
	fmov	w9, s0
	cmp	 w8, w1
	b.eq	.LBB2_10
.LBB2_8:                                // %for.body.preheader19
	sub	 w8, w1, w8
.LBB2_9:                                // %for.body
                                        // =>This Inner Loop Header: Depth=1
	mul	 w9, w9, w0
	sub	w8, w8, #1              // =1
	cbnz	w8, .LBB2_9
.LBB2_10:                               // %for.cond.for.end_crit_edge
	sxtw	x8, w9
.LBB2_11:                               // %for.end
	mov	 x0, x8
	ret
.Ltmp5:
	.size	ipow, .Ltmp5-ipow

	.globl	fpow
	.align	2
	.type	fpow,@function
fpow:                                   // @fpow
// BB#0:                                // %entry
	mov		v2.16b, v0.16b
	fmov	s0, #1.00000000
	fcmp	s1, #0.0
	b.le	.LBB3_3
// BB#1:
	fmov	s3, wzr
	fmov	s4, #1.00000000
.LBB3_2:                                // %for.body
                                        // =>This Inner Loop Header: Depth=1
	fmul	s0, s0, s2
	fadd	s3, s3, s4
	fcmp	s3, s1
	b.lt	.LBB3_2
.LBB3_3:                                // %for.end
	ret
.Ltmp7:
	.size	fpow, .Ltmp7-fpow

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI4_0:
	.word	1051372203              // float 0.333333343
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI4_1:
	.xword	4554050699414489        // double 2.25E-308
.LCPI4_2:
	.xword	-9218817986155361319    // double -2.25E-308
	.text
	.globl	sqroot
	.align	2
	.type	sqroot,@function
sqroot:                                 // @sqroot
// BB#0:                                // %entry
	fcmp	s0, #0.0
	b.le	.LBB4_5
// BB#1:                                // %do.body.preheader
	adrp	x8, .LCPI4_0
	ldr	s1, [x8, :lo12:.LCPI4_0]
	fmul	s1, s0, s1
	fmov	s2, #0.50000000
	adrp	x8, .LCPI4_1
	ldr	d3, [x8, :lo12:.LCPI4_1]
	adrp	x8, .LCPI4_2
	ldr	d4, [x8, :lo12:.LCPI4_2]
.LBB4_2:                                // %do.body
                                        // =>This Inner Loop Header: Depth=1
	mov		v5.16b, v1.16b
	fdiv	s1, s0, s5
	fadd	s1, s5, s1
	fmul	s1, s1, s2
	fsub	s5, s1, s5
	fcvt	d5, s5
	fcmp	d5, d3
	b.gt	.LBB4_2
// BB#3:                                // %do.body
                                        //   in Loop: Header=BB4_2 Depth=1
	fcmp	d5, d4
	b.lt	.LBB4_2
// BB#4:                                // %return
	mov		v0.16b, v1.16b
	ret
.LBB4_5:
	fmov	s1, wzr
	mov		v0.16b, v1.16b
	ret
.Ltmp9:
	.size	sqroot, .Ltmp9-sqroot

	.globl	fabsolute
	.align	2
	.type	fabsolute,@function
fabsolute:                              // @fabsolute
// BB#0:                                // %entry
	fcmp	s0, #0.0
	b.gt	.LBB5_2
// BB#1:                                // %cond.false
	fneg	s0, s0
.LBB5_2:                                // %cond.end
	ret
.Ltmp11:
	.size	fabsolute, .Ltmp11-fabsolute

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI6_0:
	.xword	-4609115380310813455    // double -3.1415926500000002
.LCPI6_1:
	.xword	4614256656543962353     // double 3.1415926500000002
.LCPI6_2:
	.xword	-4604611780672183960    // double -6.2831853100000004
.LCPI6_3:
	.xword	4618760256182591848     // double 6.2831853100000004
.LCPI6_4:
	.xword	4608412980290544294     // double 1.2732395400000001
.LCPI6_5:
	.xword	4600972580644005721     // double 0.40528473500000001
.LCPI6_6:
	.xword	4597274499619802317     // double 0.22500000000000001
	.text
	.globl	fsine
	.align	2
	.type	fsine,@function
fsine:                                  // @fsine
// BB#0:                                // %entry
	fcvt	d1, s0
	adrp	x8, .LCPI6_0
	ldr	d2, [x8, :lo12:.LCPI6_0]
	fcmp	d1, d2
	b.ge	.LBB6_2
// BB#1:                                // %if.then
	adrp	x8, .LCPI6_3
	ldr	d0, [x8, :lo12:.LCPI6_3]
	b	.LBB6_4
.LBB6_2:                                // %if.else
	adrp	x8, .LCPI6_1
	ldr	d2, [x8, :lo12:.LCPI6_1]
	fcmp	d1, d2
	b.le	.LBB6_5
// BB#3:                                // %if.then7
	adrp	x8, .LCPI6_2
	ldr	d0, [x8, :lo12:.LCPI6_2]
.LBB6_4:                                // %if.end10
	fadd	d0, d1, d0
	fcvt	s0, d0
.LBB6_5:                                // %if.end10
	fcvt	d2, s0
	adrp	x8, .LCPI6_4
	ldr	d1, [x8, :lo12:.LCPI6_4]
	fmul	d1, d2, d1
	fmul	d2, d2, d2
	adrp	x8, .LCPI6_5
	ldr	d3, [x8, :lo12:.LCPI6_5]
	fmul	d2, d2, d3
	fcmp	s0, #0.0
	b.ge	.LBB6_7
// BB#6:                                // %if.then13
	fadd	d0, d1, d2
	b	.LBB6_8
.LBB6_7:                                // %if.else41
	fsub	d0, d1, d2
.LBB6_8:                                // %if.then13
	fcvt	s0, d0
	fmul	s1, s0, s0
	fcmp	s0, #0.0
	b.ge	.LBB6_10
// BB#9:                                // %if.then23
	fneg	s1, s1
.LBB6_10:                               // %if.else61
	fsub	s1, s1, s0
	fcvt	d1, s1
	fcvt	d0, s0
	adrp	x8, .LCPI6_6
	ldr	d2, [x8, :lo12:.LCPI6_6]
	fmadd	d0, d1, d2, d0
	fcvt	s0, d0
	ret
.Ltmp13:
	.size	fsine, .Ltmp13-fsine

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI7_0:
	.xword	-4609115380310813455    // double -3.1415926500000002
.LCPI7_1:
	.xword	4614256656543962353     // double 3.1415926500000002
.LCPI7_2:
	.xword	-4604611780672183960    // double -6.2831853100000004
.LCPI7_3:
	.xword	4618760256182591848     // double 6.2831853100000004
.LCPI7_4:
	.xword	4609753056894073858     // double 1.5707963199999999
.LCPI7_5:
	.xword	4608412980290544294     // double 1.2732395400000001
.LCPI7_6:
	.xword	4600972580644005721     // double 0.40528473500000001
.LCPI7_7:
	.xword	4597274499619802317     // double 0.22500000000000001
	.text
	.globl	fcosine
	.align	2
	.type	fcosine,@function
fcosine:                                // @fcosine
// BB#0:                                // %entry
	fcvt	d1, s0
	adrp	x8, .LCPI7_0
	ldr	d2, [x8, :lo12:.LCPI7_0]
	fcmp	d1, d2
	b.ge	.LBB7_2
// BB#1:                                // %if.then
	adrp	x8, .LCPI7_3
	ldr	d0, [x8, :lo12:.LCPI7_3]
	b	.LBB7_4
.LBB7_2:                                // %if.else
	adrp	x8, .LCPI7_1
	ldr	d2, [x8, :lo12:.LCPI7_1]
	fcmp	d1, d2
	b.le	.LBB7_5
// BB#3:                                // %if.then7
	adrp	x8, .LCPI7_2
	ldr	d0, [x8, :lo12:.LCPI7_2]
.LBB7_4:                                // %if.end10
	fadd	d0, d1, d0
	fcvt	s0, d0
.LBB7_5:                                // %if.end10
	fcvt	d0, s0
	adrp	x8, .LCPI7_4
	ldr	d1, [x8, :lo12:.LCPI7_4]
	fadd	d0, d0, d1
	fcvt	s0, d0
	fcvt	d1, s0
	adrp	x8, .LCPI7_1
	ldr	d2, [x8, :lo12:.LCPI7_1]
	fcmp	d1, d2
	b.le	.LBB7_7
// BB#6:                                // %if.then17
	adrp	x8, .LCPI7_2
	ldr	d0, [x8, :lo12:.LCPI7_2]
	fadd	d0, d1, d0
	fcvt	s0, d0
.LBB7_7:                                // %if.end21
	fcvt	d2, s0
	adrp	x8, .LCPI7_5
	ldr	d1, [x8, :lo12:.LCPI7_5]
	fmul	d1, d2, d1
	fmul	d2, d2, d2
	adrp	x8, .LCPI7_6
	ldr	d3, [x8, :lo12:.LCPI7_6]
	fmul	d2, d2, d3
	fcmp	s0, #0.0
	b.ge	.LBB7_9
// BB#8:                                // %if.then24
	fadd	d0, d1, d2
	b	.LBB7_10
.LBB7_9:                                // %if.else52
	fsub	d0, d1, d2
.LBB7_10:                               // %if.then24
	fcvt	s0, d0
	fmul	s1, s0, s0
	fcmp	s0, #0.0
	b.ge	.LBB7_12
// BB#11:                               // %if.then34
	fneg	s1, s1
.LBB7_12:                               // %if.else72
	fsub	s1, s1, s0
	fcvt	d1, s1
	fcvt	d0, s0
	adrp	x8, .LCPI7_7
	ldr	d2, [x8, :lo12:.LCPI7_7]
	fmadd	d0, d1, d2, d0
	fcvt	s0, d0
	ret
.Ltmp15:
	.size	fcosine, .Ltmp15-fcosine

	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI8_0:
	.word	1400983510              // float 1.11078041E+12
.LCPI8_1:
	.word	1413609409              // float 3.33234124E+12
.LCPI8_4:
	.word	1042983595              // float 0.166666672
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI8_2:
	.xword	4554050699414489        // double 2.25E-308
.LCPI8_3:
	.xword	-9218817986155361319    // double -2.25E-308
	.text
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	adrp	x8, .LCPI8_0
	ldr	s3, [x8, :lo12:.LCPI8_0]
	adrp	x8, .LCPI8_1
	ldr	s4, [x8, :lo12:.LCPI8_1]
	fmov	s0, #0.50000000
	adrp	x8, .LCPI8_2
	ldr	d1, [x8, :lo12:.LCPI8_2]
	adrp	x8, .LCPI8_3
	ldr	d2, [x8, :lo12:.LCPI8_3]
.LBB8_1:                                // %do.body.i
                                        // =>This Inner Loop Header: Depth=1
	mov		v5.16b, v3.16b
	fdiv	s3, s4, s5
	fadd	s6, s5, s3
	fmul	s3, s6, s0
	fsub	s5, s3, s5
	fcvt	d5, s5
	fcmp	d5, d1
	b.gt	.LBB8_1
// BB#2:                                // %do.body.i
                                        //   in Loop: Header=BB8_1 Depth=1
	fcmp	d5, d2
	b.lt	.LBB8_1
// BB#3:                                // %sqroot.exit
	fcmp	s3, #0.0
	b.le	.LBB8_12
// BB#4:                                // %do.body.preheader.i16
	adrp	x8, .LCPI8_4
	ldr	s5, [x8, :lo12:.LCPI8_4]
	fmul	s4, s6, s5
.LBB8_5:                                // %do.body.i26
                                        // =>This Inner Loop Header: Depth=1
	mov		v7.16b, v4.16b
	fdiv	s4, s3, s7
	fadd	s6, s7, s4
	fmul	s4, s6, s0
	fsub	s7, s4, s7
	fcvt	d7, s7
	fcmp	d7, d1
	b.gt	.LBB8_5
// BB#6:                                // %do.body.i26
                                        //   in Loop: Header=BB8_5 Depth=1
	fcmp	d7, d2
	b.lt	.LBB8_5
// BB#7:                                // %sqroot.exit28
	fcmp	s4, #0.0
	b.le	.LBB8_13
// BB#8:                                // %do.body.preheader.i
	fmul	s3, s6, s5
.LBB8_9:                                // %do.body.i12
                                        // =>This Inner Loop Header: Depth=1
	mov		v5.16b, v3.16b
	fdiv	s3, s4, s5
	fadd	s3, s5, s3
	fmul	s3, s3, s0
	fsub	s5, s3, s5
	fcvt	d5, s5
	fcmp	d5, d1
	b.gt	.LBB8_9
// BB#10:                               // %do.body.i12
                                        //   in Loop: Header=BB8_9 Depth=1
	fcmp	d5, d2
	b.lt	.LBB8_9
// BB#11:                               // %sqroot.exit13.loopexit
	fcvtzs	w0, s3
	ret
.LBB8_12:
	mov	 w0, wzr
	ret
.LBB8_13:
	mov	 w0, wzr
	ret
.Ltmp17:
	.size	main, .Ltmp17-main


	.ident	"clang version 3.5.0 "
