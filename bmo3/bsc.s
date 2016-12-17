	.text
	.file	"bsc.c"
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
	.word	1074137746              // float 2.09439516
.LCPI8_1:
	.word	1086918619              // float 6.28318548
.LCPI8_4:
	.word	1059760811              // float 0.666666686
.LCPI8_5:
	.word	1108606976              // float 37
.LCPI8_6:
	.word	1076754516              // float 2.71828175
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI8_2:
	.xword	4554050699414489        // double 2.25E-308
.LCPI8_3:
	.xword	-9218817986155361319    // double -2.25E-308
.LCPI8_7:
	.xword	4604029899060858061     // double 0.65000000000000002
.LCPI8_8:
	.xword	4604483709361366815     // double 0.70038306444368803
.LCPI8_9:
	.xword	4585242682365311966     // double 0.035262496599891099
.LCPI8_10:
	.xword	4618862461878562595     // double 6.3739622035316499
.LCPI8_11:
	.xword	4629969628904301617     // double 33.912866078382997
.LCPI8_12:
	.xword	4637587295927897404     // double 112.079291497871
.LCPI8_13:
	.xword	4641987278042991858     // double 221.21359616993101
.LCPI8_14:
	.xword	4641951856941385701     // double 220.206867912376
.LCPI8_15:
	.xword	4610585641154542865     // double 1.7556671631826399
.LCPI8_16:
	.xword	4591033472335690698     // double 0.088388347648318404
.LCPI8_17:
	.xword	4625214881692112029     // double 16.064177579207001
.LCPI8_18:
	.xword	4635807068080809370     // double 86.780732202946098
.LCPI8_19:
	.xword	4643924829630265376     // double 296.56424877967402
.LCPI8_20:
	.xword	4648817261744363383     // double 637.333633378831
.LCPI8_21:
	.xword	4650193787666601802     // double 793.82651251994798
.LCPI8_22:
	.xword	4646455456568756197     // double 440.413735824752
	.text
	.globl	normalDistribution
	.align	2
	.type	normalDistribution,@function
normalDistribution:                     // @normalDistribution
// BB#0:                                // %entry
	adrp	x8, .LCPI8_0
	ldr	s1, [x8, :lo12:.LCPI8_0]
	adrp	x8, .LCPI8_1
	ldr	s5, [x8, :lo12:.LCPI8_1]
	fmov	s2, #0.50000000
	adrp	x8, .LCPI8_2
	ldr	d3, [x8, :lo12:.LCPI8_2]
	adrp	x8, .LCPI8_3
	ldr	d4, [x8, :lo12:.LCPI8_3]
.LBB8_1:                                // %do.body.i
                                        // =>This Inner Loop Header: Depth=1
	mov		v6.16b, v1.16b
	fdiv	s1, s5, s6
	fadd	s1, s6, s1
	fmul	s1, s1, s2
	fsub	s6, s1, s6
	fcvt	d6, s6
	fcmp	d6, d3
	b.gt	.LBB8_1
// BB#2:                                // %do.body.i
                                        //   in Loop: Header=BB8_1 Depth=1
	fcmp	d6, d4
	b.lt	.LBB8_1
// BB#3:                                // %do.body.i93.preheader
	adrp	x8, .LCPI8_4
	ldr	s5, [x8, :lo12:.LCPI8_4]
	fmov	s6, #2.00000000
.LBB8_4:                                // %do.body.i93
                                        // =>This Inner Loop Header: Depth=1
	mov		v7.16b, v5.16b
	fdiv	s5, s6, s7
	fadd	s5, s7, s5
	fmul	s5, s5, s2
	fsub	s7, s5, s7
	fcvt	d7, s7
	fcmp	d7, d3
	b.gt	.LBB8_4
// BB#5:                                // %do.body.i93
                                        //   in Loop: Header=BB8_4 Depth=1
	fcmp	d7, d4
	b.lt	.LBB8_4
// BB#6:                                // %sqroot.exit94
	fcvt	s2, d0
	fcmp	s2, #0.0
	fneg	s3, s2
	fcsel	s3, s2, s3, gt
	adrp	x8, .LCPI8_5
	ldr	s2, [x8, :lo12:.LCPI8_5]
	fcmp	s3, s2
	b.le	.LBB8_8
// BB#7:
	fmov	d1, xzr
	b	.LBB8_16
.LBB8_8:                                // %if.then
	fcvt	d2, s1
	fcvt	d1, s3
	fcvt	d3, s5
	fmov	d4, #10.00000000
	fdiv	d4, d4, d3
	fmul	d3, d1, d1
	fmov	d5, #-0.50000000
	fmul	d3, d3, d5
	fcvt	s3, d3
	fcmp	s3, #0.0
	b.le	.LBB8_12
// BB#9:
	fmov	s6, wzr
	fmov	s5, #1.00000000
	adrp	x8, .LCPI8_6
	ldr	s7, [x8, :lo12:.LCPI8_6]
	fmov	s16, #1.00000000
.LBB8_10:                               // %for.body.i
                                        // =>This Inner Loop Header: Depth=1
	fmul	s5, s5, s7
	fadd	s6, s6, s16
	fcmp	s6, s3
	b.lt	.LBB8_10
// BB#11:                               // %fpow.exit.loopexit
	fcvt	d3, s5
	b	.LBB8_13
.LBB8_12:
	fmov	d3, #1.00000000
.LBB8_13:                               // %fpow.exit
	fdiv	d3, d3, d2
	fcmp	d1, d4
	b.ge	.LBB8_15
// BB#14:                               // %if.then14
	adrp	x8, .LCPI8_8
	ldr	d4, [x8, :lo12:.LCPI8_8]
	adrp	x8, .LCPI8_9
	ldr	d5, [x8, :lo12:.LCPI8_9]
	fmadd	d4, d1, d5, d4
	adrp	x8, .LCPI8_10
	ldr	d5, [x8, :lo12:.LCPI8_10]
	fmadd	d4, d1, d4, d5
	adrp	x8, .LCPI8_11
	ldr	d5, [x8, :lo12:.LCPI8_11]
	fmadd	d4, d1, d4, d5
	adrp	x8, .LCPI8_12
	ldr	d5, [x8, :lo12:.LCPI8_12]
	fmadd	d4, d1, d4, d5
	adrp	x8, .LCPI8_13
	ldr	d5, [x8, :lo12:.LCPI8_13]
	fmadd	d4, d1, d4, d5
	adrp	x8, .LCPI8_14
	ldr	d5, [x8, :lo12:.LCPI8_14]
	fmadd	d4, d1, d4, d5
	adrp	x8, .LCPI8_15
	ldr	d5, [x8, :lo12:.LCPI8_15]
	adrp	x8, .LCPI8_16
	ldr	d6, [x8, :lo12:.LCPI8_16]
	fmadd	d5, d1, d6, d5
	adrp	x8, .LCPI8_17
	ldr	d6, [x8, :lo12:.LCPI8_17]
	fmadd	d5, d1, d5, d6
	adrp	x8, .LCPI8_18
	ldr	d6, [x8, :lo12:.LCPI8_18]
	fmadd	d5, d1, d5, d6
	adrp	x8, .LCPI8_19
	ldr	d6, [x8, :lo12:.LCPI8_19]
	fmadd	d5, d1, d5, d6
	adrp	x8, .LCPI8_20
	ldr	d6, [x8, :lo12:.LCPI8_20]
	fmadd	d5, d1, d5, d6
	adrp	x8, .LCPI8_21
	ldr	d6, [x8, :lo12:.LCPI8_21]
	fmadd	d5, d1, d5, d6
	adrp	x8, .LCPI8_22
	ldr	d6, [x8, :lo12:.LCPI8_22]
	fmadd	d1, d1, d5, d6
	fmul	d2, d2, d3
	fmul	d2, d4, d2
	fdiv	d1, d2, d1
	b	.LBB8_16
.LBB8_15:                               // %if.else
	adrp	x8, .LCPI8_7
	ldr	d2, [x8, :lo12:.LCPI8_7]
	fadd	d2, d1, d2
	fmov	d4, #4.00000000
	fdiv	d2, d4, d2
	fadd	d2, d1, d2
	fmov	d4, #3.00000000
	fdiv	d2, d4, d2
	fadd	d2, d1, d2
	fmov	d4, #2.00000000
	fdiv	d2, d4, d2
	fadd	d2, d1, d2
	fmov	d4, #1.00000000
	fdiv	d2, d4, d2
	fadd	d1, d1, d2
	fdiv	d1, d3, d1
.LBB8_16:                               // %if.end53
	fcmp	d0, #0.0
	fmov	d0, #1.00000000
	fsub	d0, d0, d1
	fcsel	d0, d1, d0, lt
	ret
.Ltmp17:
	.size	normalDistribution, .Ltmp17-normalDistribution

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI9_0:
	.xword	4397347889687374747     // double 9.9999999999999999E-15
.LCPI9_8:
	.xword	4554050699414489        // double 2.25E-308
.LCPI9_9:
	.xword	-9218817986155361319    // double -2.25E-308
	.section	.rodata.cst4,"aM",@progbits,4
	.align	2
.LCPI9_1:
	.word	3271062391              // float -124.225517
.LCPI9_2:
	.word	872415232               // float 1.1920929E-7
.LCPI9_3:
	.word	3217014645              // float -1.4980303
.LCPI9_4:
	.word	1052001529              // float 0.35208872
.LCPI9_5:
	.word	3218925987              // float -1.72588003
.LCPI9_6:
	.word	1060205080              // float 0.693147182
.LCPI9_7:
	.word	1051372203              // float 0.333333343
.LCPI9_10:
	.word	2147483648              // float -0
.LCPI9_11:
	.word	1076754516              // float 2.71828175
	.text
	.globl	callOptionPrice
	.align	2
	.type	callOptionPrice,@function
callOptionPrice:                        // @callOptionPrice
// BB#0:                                // %entry
	stp	d13, d12, [sp, #-64]!
	stp	d11, d10, [sp, #16]
	stp	d9, d8, [sp, #32]
	stp	x29, x30, [sp, #48]
	add	x29, sp, #48            // =48
	mov		v10.16b, v3.16b
	mov		v8.16b, v2.16b
	mov		v9.16b, v0.16b
	fmov	d0, xzr
	adrp	x8, .LCPI9_0
	ldr	d2, [x8, :lo12:.LCPI9_0]
	fcmp	d9, d2
	b.lt	.LBB9_33
// BB#1:                                // %if.end
	fsub	d12, d5, d1
	fcmp	d4, d2
	b.ge	.LBB9_6
// BB#2:                                // %if.then2
	fmul	d1, d12, d10
	fcvt	s2, d1
	fneg	s1, s2
	adrp	x8, .LCPI9_10
	ldr	s3, [x8, :lo12:.LCPI9_10]
	fcmp	s2, s3
	b.ge	.LBB9_11
// BB#3:
	fmov	s5, wzr
	fmov	s4, #1.00000000
	adrp	x8, .LCPI9_11
	ldr	s6, [x8, :lo12:.LCPI9_11]
	fmov	s7, #1.00000000
.LBB9_4:                                // %for.body.i
                                        // =>This Inner Loop Header: Depth=1
	fmul	s4, s4, s6
	fadd	s5, s5, s7
	fcmp	s5, s1
	b.lt	.LBB9_4
// BB#5:                                // %fpow.exit.loopexit
	fcvt	d4, s4
	b	.LBB9_12
.LBB9_6:                                // %if.end17
	fcvt	s1, d12
	fcmp	s1, #0.0
	mov		v3.16b, v1.16b
	b.gt	.LBB9_8
// BB#7:                                // %cond.false.i
	fneg	s3, s1
.LBB9_8:                                // %fabsolute.exit
	fcvt	d3, s3
	fcmp	d3, d2
	b.ge	.LBB9_17
// BB#9:                                // %if.then24
	fcmp	d9, d8
	b.lt	.LBB9_33
// BB#10:                               // %if.else28
	fsub	d0, d9, d8
	b	.LBB9_33
.LBB9_11:
	fmov	d4, #1.00000000
.LBB9_12:                               // %fpow.exit
	fmul	d4, d4, d8
	fcmp	d4, d9
	b.gt	.LBB9_33
// BB#13:                               // %if.else
	fcmp	s2, s3
	b.ge	.LBB9_25
// BB#14:
	fmov	s2, wzr
	fmov	s0, #1.00000000
	adrp	x8, .LCPI9_11
	ldr	s3, [x8, :lo12:.LCPI9_11]
	fmov	s4, #1.00000000
.LBB9_15:                               // %for.body.i123
                                        // =>This Inner Loop Header: Depth=1
	fmul	s0, s0, s3
	fadd	s2, s2, s4
	fcmp	s2, s1
	b.lt	.LBB9_15
// BB#16:                               // %fpow.exit125.loopexit
	fcvt	d0, s0
	fmsub	d0, d0, d8, d9
	b	.LBB9_33
.LBB9_17:                               // %if.end30
	fdiv	d0, d9, d8
	fcvt	s0, d0
	fmov	w8, s0
	orr	w9, wzr, #0x3f000000
	bfxil	w9, w8, #0, #23
	ucvtf	s0, w8
	adrp	x8, .LCPI9_1
	ldr	s2, [x8, :lo12:.LCPI9_1]
	adrp	x8, .LCPI9_2
	ldr	s3, [x8, :lo12:.LCPI9_2]
	fmadd	s0, s0, s3, s2
	fmov	s2, w9
	adrp	x8, .LCPI9_3
	ldr	s3, [x8, :lo12:.LCPI9_3]
	fmadd	s0, s2, s3, s0
	adrp	x8, .LCPI9_4
	ldr	s3, [x8, :lo12:.LCPI9_4]
	fadd	s2, s2, s3
	adrp	x8, .LCPI9_5
	ldr	s3, [x8, :lo12:.LCPI9_5]
	fdiv	s2, s3, s2
	fadd	s0, s0, s2
	adrp	x8, .LCPI9_6
	ldr	s2, [x8, :lo12:.LCPI9_6]
	fmul	s0, s0, s2
	fcvt	d2, s0
	fmul	d0, d4, d4
	fmov	d3, #0.50000000
	fmul	d3, d0, d3
	fadd	d0, d3, d10
	fmadd	d0, d12, d0, d2
	fcmp	s1, #0.0
	b.le	.LBB9_26
// BB#18:                               // %do.body.preheader.i133
	adrp	x8, .LCPI9_7
	ldr	s5, [x8, :lo12:.LCPI9_7]
	fmul	s6, s1, s5
	fmov	s5, #0.50000000
	adrp	x8, .LCPI9_8
	ldr	d7, [x8, :lo12:.LCPI9_8]
	adrp	x8, .LCPI9_9
	ldr	d16, [x8, :lo12:.LCPI9_9]
	mov		v17.16b, v6.16b
.LBB9_19:                               // %do.body.i143
                                        // =>This Inner Loop Header: Depth=1
	mov		v18.16b, v17.16b
	fdiv	s17, s1, s18
	fadd	s17, s18, s17
	fmul	s17, s17, s5
	fsub	s18, s17, s18
	fcvt	d18, s18
	fcmp	d18, d7
	b.gt	.LBB9_19
// BB#20:                               // %do.body.i143
                                        //   in Loop: Header=BB9_19 Depth=1
	fcmp	d18, d16
	b.lt	.LBB9_19
// BB#21:                               // %do.body.preheader.i
	fcvt	d17, s17
	fmul	d17, d17, d4
	fdiv	d0, d0, d17
.LBB9_22:                               // %do.body.i
                                        // =>This Inner Loop Header: Depth=1
	mov		v17.16b, v6.16b
	fdiv	s6, s1, s17
	fadd	s6, s17, s6
	fmul	s6, s6, s5
	fsub	s17, s6, s17
	fcvt	d17, s17
	fcmp	d17, d7
	b.gt	.LBB9_22
// BB#23:                               // %do.body.i
                                        //   in Loop: Header=BB9_22 Depth=1
	fcmp	d17, d16
	b.lt	.LBB9_22
// BB#24:                               // %sqroot.exit.loopexit
	fcvt	d1, s6
	b	.LBB9_27
.LBB9_25:
	fmov	d0, #1.00000000
	fmsub	d0, d0, d8, d9
	b	.LBB9_33
.LBB9_26:                               // %sqroot.exit145.thread
	fmov	d1, xzr
	fdiv	d0, d0, d1
.LBB9_27:                               // %sqroot.exit
	fsub	d3, d10, d3
	fmadd	d2, d12, d3, d2
	fmul	d1, d1, d4
	fdiv	d11, d2, d1
	bl	normalDistribution
	fmul	d9, d0, d9
	mov		v0.16b, v11.16b
	bl	normalDistribution
	fmul	d0, d0, d8
	fmul	d1, d12, d10
	fcvt	s1, d1
	adrp	x8, .LCPI9_10
	ldr	s2, [x8, :lo12:.LCPI9_10]
	fcmp	s1, s2
	b.ge	.LBB9_31
// BB#28:
	fneg	s1, s1
	fmov	s3, wzr
	fmov	s2, #1.00000000
	adrp	x8, .LCPI9_11
	ldr	s4, [x8, :lo12:.LCPI9_11]
	fmov	s5, #1.00000000
.LBB9_29:                               // %for.body.i114
                                        // =>This Inner Loop Header: Depth=1
	fmul	s2, s2, s4
	fadd	s3, s3, s5
	fcmp	s3, s1
	b.lt	.LBB9_29
// BB#30:                               // %fpow.exit116.loopexit
	fcvt	d1, s2
	b	.LBB9_32
.LBB9_31:
	fmov	d1, #1.00000000
.LBB9_32:                               // %fpow.exit116
	fmsub	d0, d0, d1, d9
.LBB9_33:                               // %return
	ldp	x29, x30, [sp, #48]
	ldp	d9, d8, [sp, #32]
	ldp	d11, d10, [sp, #16]
	ldp	d13, d12, [sp], #64
	ret
.Ltmp18:
	.size	callOptionPrice, .Ltmp18-callOptionPrice

	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LCPI10_0:
	.xword	4587366580439587226     // double 0.050000000000000003
.LCPI10_1:
	.xword	4596373779694328218     // double 0.20000000000000001
	.text
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	d11, d10, [sp, #-64]!
	stp	d9, d8, [sp, #16]
	stp	x20, x19, [sp, #32]
	stp	x29, x30, [sp, #48]
	add	x29, sp, #48            // =48
	sub	sp, sp, #160            // =160
	mov	 x19, xzr
	mov	 x20, sp
	adrp	x8, .LCPI10_0
	ldr	d8, [x8, :lo12:.LCPI10_0]
	adrp	x8, .LCPI10_1
	ldr	d9, [x8, :lo12:.LCPI10_1]
	fmov	d10, xzr
	fmov	d11, #1.00000000
.LBB10_1:                               // %for.body
                                        // =>This Inner Loop Header: Depth=1
	scvtf	d0, w19
	mov		v1.16b, v10.16b
	mov		v2.16b, v11.16b
	mov		v3.16b, v8.16b
	mov		v4.16b, v9.16b
	mov		v5.16b, v11.16b
	bl	callOptionPrice
	str	d0, [x20], #8
	add	x19, x19, #10           // =10
	cmp	 x19, #200              // =200
	b.ne	.LBB10_1
// BB#2:                                // %for.end
	ldr	d0, [sp, #152]
	fcvtzs	w0, d0
	sub	sp, x29, #48            // =48
	ldp	x29, x30, [sp, #48]
	ldp	x20, x19, [sp, #32]
	ldp	d9, d8, [sp, #16]
	ldp	d11, d10, [sp], #64
	ret
.Ltmp19:
	.size	main, .Ltmp19-main


	.ident	"clang version 3.5.0 "
