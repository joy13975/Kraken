	.text
	.file	"fac_it.c"
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LCPI0_0:
	.word	0                       // 0x0
	.word	4294967295              // 0xffffffff
	.word	4294967294              // 0xfffffffe
	.word	4294967293              // 0xfffffffd
.LCPI0_1:
	.word	4294967292              // 0xfffffffc
	.word	4294967291              // 0xfffffffb
	.word	4294967290              // 0xfffffffa
	.word	4294967289              // 0xfffffff9
	.text
	.globl	fac
	.align	2
	.type	fac,@function
fac:                                    // @fac
// BB#0:                                // %entry
	subs	w9, w0, #1              // =1
	b.ne	.LBB0_2
// BB#1:
	orr	w8, wzr, #0x1
	mov	 w0, w8
	ret
.LBB0_2:                                // %overflow.checked
	and	w10, w9, #0xfffffff8
	cbz	w10, .LBB0_6
// BB#3:                                // %vector.body.preheader
	sub	 w8, w0, w10
	movi	v0.4s, #0x1
	adrp	x11, .LCPI0_0
	ldr	q2, [x11, :lo12:.LCPI0_0]
	adrp	x11, .LCPI0_1
	ldr	q3, [x11, :lo12:.LCPI0_1]
	mov	 w11, w10
	mov		v1.16b, v0.16b
.LBB0_4:                                // %vector.body
                                        // =>This Inner Loop Header: Depth=1
	dup	v4.4s, w0
	add	v5.4s, v4.4s, v2.4s
	add	v4.4s, v4.4s, v3.4s
	mul	v0.4s, v0.4s, v5.4s
	mul	v1.4s, v1.4s, v4.4s
	sub	w0, w0, #8              // =8
	sub	w11, w11, #8            // =8
	cbnz	w11, .LBB0_4
// BB#5:
	mov	 w0, w8
	b	.LBB0_7
.LBB0_6:
	mov	 w10, wzr
	movi	v0.4s, #0x1
	mov		v1.16b, v0.16b
.LBB0_7:                                // %middle.block
	mul	v0.4s, v1.4s, v0.4s
	ext	v1.16b, v0.16b, v0.16b, #8
	mul	v0.4s, v0.4s, v1.4s
	mul	v0.4s, v0.4s, v0.s[1]
	fmov	w8, s0
	cmp	 w9, w10
	b.eq	.LBB0_9
.LBB0_8:                                // %while.body
                                        // =>This Inner Loop Header: Depth=1
	mul	 w8, w8, w0
	sub	w0, w0, #1              // =1
	cmp	 w0, #1                 // =1
	b.ne	.LBB0_8
.LBB0_9:                                // %while.end
	mov	 w0, w8
	ret
.Ltmp1:
	.size	fac, .Ltmp1-fac

	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	movz	w0, #0x37, lsl #16
	movk	w0, #0x5f00
	ret
.Ltmp3:
	.size	main, .Ltmp3-main


	.ident	"clang version 3.5.0 "
