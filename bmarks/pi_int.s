	.text
	.file	"pi_int.c"
	.globl	main
	.align	2
	.type	main,@function
main:                                   // @main
// BB#0:                                // %entry
	stp	x28, x27, [sp, #-16]!
	sub	sp, sp, #2, lsl #12     // =8192
	sub	sp, sp, #3024           // =3024
	movn	x11, #0x2bbf
	add	x8, sp, #12             // =12
	movz	w9, #0x7d0
	dup	v0.4s, w9
	movz	w9, #0xaef
	movz	w10, #0xaf0
.LBB0_1:                                // %vector.body
                                        // =>This Inner Loop Header: Depth=1
	add	 x12, x8, x11
	str	q0, [x12, #11200]
	str	q0, [x12, #11216]
	add	x11, x11, #32           // =32
	cbnz	x11, .LBB0_1
// BB#2:
	mov	 w16, wzr
	movz	w12, #0x15dd
	movz	w13, #0x2710
	movz	w14, #0x68db, lsl #16
	movk	w14, #0x8bad
.LBB0_3:                                // %for.cond4.preheader
                                        // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_4 Depth 2
	mov	 w11, w16
	lsl	x16, x10, #2
	ldr	 w15, [x8, x16]
	mul	 w17, w15, w13
	lsl	x15, x10, #1
	sub	w18, w15, #1            // =1
	sdiv	w15, w17, w18
	msub	w17, w15, w18, w17
	str	 w17, [x8, x16]
	mov	 w16, w12
	mov	 x17, x9
.LBB0_4:                                // %if.end
                                        //   Parent Loop BB0_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	lsl	x18, x17, #2
	ldr	 w0, [x8, x18]
	mul	 w0, w0, w13
	madd	w0, w15, w17, w0
	sdiv	w15, w0, w16
	msub	w0, w15, w16, w0
	str	 w0, [x8, x18]
	sub	x17, x17, #1            // =1
	sub	w16, w16, #2            // =2
	cbnz	w17, .LBB0_4
// BB#5:                                // %for.end12
                                        //   in Loop: Header=BB0_3 Depth=1
	sxtw	x16, w15
	mul	 x16, x16, x14
	lsr	x17, x16, #63
	asr	x16, x16, #44
	add	 w16, w16, w17
	msub	w16, w16, w13, w15
	sub	x10, x10, #14           // =14
	sub	x9, x9, #14             // =14
	sub	w12, w12, #28           // =28
	cmp	 w10, #0                // =0
	b.gt	.LBB0_3
// BB#6:                                // %for.end18
	sxtw	x8, w15
	movz	w9, #0x68db, lsl #16
	movk	w9, #0x8bad
	mul	 x8, x8, x9
	lsr	x9, x8, #63
	asr	x8, x8, #44
	add	 w8, w8, w9
	add	 w0, w8, w11
	add	sp, sp, #2, lsl #12     // =8192
	add	sp, sp, #3024           // =3024
	ldp	x28, x27, [sp], #16
	ret
.Ltmp0:
	.size	main, .Ltmp0-main


	.ident	"clang version 3.5.0 "
